rm(list = ls())

require('ggplot2')
library('grid')
require('gridExtra')
library('gtable')
library('Rmisc')
library('sysfonts')
library('Hmisc')
library('reshape2')
library('dplyr')
library('Cairo')

annotation.font <- 'Linux Biolinum O'

ggsave <- ggplot2::ggsave; body(ggsave) <- body(ggplot2::ggsave)[-2]

color.palette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
color.low <- color.palette[7]
color.high <- color.palette[4]
color.highlight <- 'black'

linetypes.for <- function(values) {
  seq(1, length(unique(values)))
}

label.tdch <- expression(paste(T[DCH], ' ', (s)))
label.ea <- expression('E[A] (s)')
label.power.drain <- 'Power Drain PD'
label.signalling.intensity <- 'Signalling Intensity SI'
label.signalling.frequency <- 'Signalling Frequency SF'
label.application <- 'Application'
label.evaluation.type <- 'Model'
label.cA <- expression(c[A])
label.interarrival.time <- expression(paste('Packet Interarrival Time ', A, ' (s)'))
label.interarrival.time.cdf <- expression(P(A <= a))
label.lag <- 'Lag Length'
label.interarrival.sample.autocorrelation <- 'Sample Autocorrelation\n of Interarrival Times'
label.page.load.time <- 'Page Load Time (s)'
label.qoe <- 'Mean Opinion Score'
label.bandwidth <- expression(paste('Bandwidth b ', (Mbit^-1)))
label.bandwidth.at.time.t <- expression(paste("Bandwidth ", b[d(t)], " (", Mbit^-1, ")"))
label.cdf.bandwidth <- expression(P(B <= b))
label.direction <- 'Bandwidth'
label.type <- 'Type'
label.server.preparation.time <- 'Time t (s)'
label.cdf.server.preparation.time <- expression(P(T <= t))
label.image.size <- 'Size s (MiB)'
label.cdf.image.size <- expression(P(S <= s))
label.waiting.time <- "Mean Waiting Time (s)"
label.size.threshold <- "Size Threshold (MB)"
label.intervall.time <- "Interval (s)"
label.connection.count <- "Mean Connection Count"
label.disconnection.time <- "Mean Relative Disconnected Time (%)"
label.mean.queue.length <- "Mean Queue Length"
label.mechanism <- "Mechanism"
label.normalized.threshold <- "Normalized Synchronization Threshold (s)"
label.number.of.stalling.events <- 'Number of Stalling Events'
label.qoe.model <- 'QoE Model'
label.stalling.duration <- 'Stalling Duration per Event (s)'
label.time <- 'Time (s)'
label.buffer <- 'Buffer (s)'
label.unplayed.buffer <- expression(paste("Buffer ", t[u](t), " (s)"))
label.bitrate <- expression(paste('Video Bitrate ', (Mbit^-1)))
label.energy <- 'Energy Consumption (kJ)'
label.wasted.traffic <- 'Wasted Traffic (Mbit)'
label.user.model <- 'User Model'
label.connections <- 'Connection Count'
label.buffer.lower <- expression(paste("Stop Threshold ", theta))
label.buffer.size <- expression(paste("Size Size ", Theta))
label.abort.time <- 'Abort Time t (s)'
label.pdf.abort.time <- 'PDF A(t)'
label.user.model <- 'User Model'
label.playback.status <- 'Playback Status'
label.finite <- 'Video Browsing'
label.infinite <- 'Steady State'
label.offered.load <- 'Offered Load'
label.alpha <- expression(paste("Duration Parameter ", alpha)) 
label.beta <- expression(paste("Interruption Parameter ", beta)) 
label.prebuffering.sensitivity <- expression(paste("Prebuffering Parameter ", gamma))
label.normalized.video.buffer <- expression(paste('Normalized Video Buffer ', d^'*', ' (s)'))
label.power <- 'Power Consumption (kW)'
label.pareto <- 'Pareto Optimal'
label.number.servers <- 'Number of Available Servers'
label.parameter <- 'Parameter'
label.waiting.time.ms <- "Mean Waiting Time (ms)"
label.tunnel.iat <- 'Tunnel Interarrival Time t (s)'
label.cdf.iat <- expression(P(T <= t))
label.distribution <- 'Distribution'
label.tunnel.duration <- 'Tunnel Duration d (s)'
label.cdf.duration <- expression(P(D <= d))
label.number.instances <- 'Active Instances I'
label.cdf.number.instances <- expression(P(I <= i))
label.max.instances <- expression(paste('Maximum Number of Active Instances ', S[max]))
label.max.tunnels <- expression(paste('Maximum Number of Tunnels ', n))
label.blocking.probability <- expression(paste('Blocking Probability ', p[B]))
label.mean.resource.utilization <- expression(paste('Mean Tunnel Count')) 
label.startstop.duration <- expression(paste('Start Up and Shut Down Time ', (s)))
label.campaign.interarrival <- expression('Campaign Interarrival Time t'[c]*' (h)')
label.cdf.campaign.interarrival <- expression(P(T <= t[c]))
label.campaign.size <- expression('Campaign Interarrival Time ', Theta)
label.cdf.campaign.size <- expression(P(T <= Theta))
label.number.of.workers <- 'Number of Workers c'
label.worker.utilization <- expression(paste('Worker Utilization ', rho))
label.mean.task.length <- 'Mean Task Length E[B] (s)'
label.mean.task.delay <- 'Task Pre-processing Delay E[D] (s)'
label.campaign.arrival.distribution <- 'Campaign Arrival'
label.campaign.rate <- 'Rate'
unit.labeller <- function(unit) {
  passed.unit <- substitute(unit)
  
  function(variable, value) {
    do.call(expression, lapply(levels(value)[value], function(value) {
      bquote(paste(.(value), ' ', .(passed.unit)))
    }))
  }
}

font.size <- 8
annotation.font.size <- (4/15) * font.size

plot_options = theme(
  plot.margin = unit(c(0.2, 0, 0, 0), "cm"),
  legend.position = "bottom",
  legend.direction = "horizontal",
  #legend.box = "vertical",
  legend.key.height = unit(0.4, "cm"),
  legend.margin = unit(-0.6, "cm"),
  text         = element_text(family="Linux Biolinum O", size = font.size),
  axis.title.x = element_text(family="Linux Biolinum O", size = font.size),
  axis.title.y = element_text(family="Linux Biolinum O", size = font.size)
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
  #plot <- adjust.legend.spacing(plot)
  print(filename)
  ggsave(filename, plot=plot,height = rowHeight, width = pageWidth, units = units, device=cairo_pdf)
  #embed_fonts(filename, outfile=filename)
}

notation.si <- function(label) {
  label <- format(label, scientific = TRUE)
  label <- gsub("e", "%*%10^", label)
  parse(text=label)
}
