rm(list = ls())

require('ggplot2')
library('grid')
require('gridExtra')
library('gtable')
library('Rmisc')
library('extrafont')

loadfonts()

ggsave <- ggplot2::ggsave; body(ggsave) <- body(ggplot2::ggsave)[-2]

color.palette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
color.low <- color.palette[1]
color.high <- color.palette[2]

linetypes.for <- function(values) {
  seq(1, length(unique(values)))
}

label.tdch <- expression(T[DCH])
label.ea <- expression('E[A]')
label.power.drain <- 'Power Drain PD'
label.signalling.intensity <- 'Signalling Intensity SI'
label.application <- 'Application'
label.evaluation.type <- 'Evaluation Type'
label.cA <- expression(c[A])
label.interarrival.time <- expression(paste('Packet Interarrival Time ', A, ' (s)'))
label.interarrival.time.cdf <- expression(P(A <= a))

plot_options = theme(
  plot.margin = unit(c(0.2, 0, 0, 0), "cm"),
  legend.position = "bottom",
  legend.direction = "horizontal",
  #legend.box = "vertical",
  legend.key.height = unit(0.4, "cm"),
  legend.margin = unit(-0.8, "cm"),
  text         = element_text(family="CM Roman", size = 8),
  axis.title.x = element_text(family="CM Roman", size = 8),
  axis.title.y = element_text(family="CM Roman", size = 8)
)

units <- "cm"

pageWidth <- 9.5
rowHeight <- 6

adjust.legend.spacing <- function(plot, spacing = unit(-.4, 'lines')) {
  data <- ggplot_build(plot)
  gtable <- ggplot_gtable(data)
  lbox <- which(sapply(gtable$grobs, paste) == "gtable[guide-box]")
  guide <- gtable$grobs[[lbox]]
  if(length(guide$heights) == 5) {
    gtable$grobs[[lbox]]$heights <- unit.c(guide$heights[1:2],
                                           unit(-.4,'lines'),
                                           guide$heights[4:5])
  }
  grid.draw(gtable)
  plot <- arrangeGrob(gtable)
}

save.full.row.plot <- function(plot, filename = commandArgs(TRUE)[1]) {
  plot <- plot + plot_options + theme(legend.box = "vertical")
  plot <- adjust.legend.spacing(plot)
  print(filename)
  ggsave(filename, plot=plot,height = rowHeight, width = pageWidth, units = units)
  embed_fonts(filename, outfile=filename)
}