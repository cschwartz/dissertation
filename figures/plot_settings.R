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

# 2.2 done
label.tdch <- expression(paste('DCH timeout ', T[DCH], ' ', (s)))
label.ea <- expression(paste('Mean inter-packet time E[A] (s)'))
label.power.drain <- 'Power drain PD'
label.signalling.intensity <- 'Signalling intensity SI'
label.signalling.frequency <- 'Signalling frequency SF'
label.application <- 'Application'
label.evaluation.type <- 'Model'
label.cA <- expression(c[A])
label.interarrival.time <- expression(paste('Packet inter-arrival time ', A, ' (s)'))
label.interarrival.time.cdf <- expression(P(A <= a))
label.lag <- 'Lag length'
label.interarrival.sample.autocorrelation <- 'Sample autocorrelation\n of inter-arrival times'
label.page.load.time <- 'Page load time t (s)'
label.qoe <- 'Mean Opinion Score MOS'

label.bandwidth <- expression(paste('Bandwidth b ', (Mbit^-1)))
label.bandwidth.at.time.t <- expression(paste("Bandwidth ", b[d(t)], " (", Mbit^-1, ")"))
label.cdf.bandwidth <- expression(P(B <= b))
label.direction <- 'Bandwidth'
label.type <- 'Type'
label.server.preparation.time <- 'Time t (s)'
label.cdf.server.preparation.time <- expression(P(T <= t))
label.image.size <- 'Size s (MiB)'
label.cdf.image.size <- expression(P(S <= s))
label.waiting.time <- expression(paste("Mean waiting time ", Sigma, " (s)"))
label.size.threshold <- expression(paste("Size threshold ", T[s], " (MB)"))
label.intervall.time <- expression(paste("Interval length ", T[i], " (s)"))
label.connection.count <- expression(paste("Mean connection count ", Kappa))
label.disconnection.time <- expression(paste("Mean relative disconnected time ", Delta, " (%)"))
label.mean.queue.length <- "Mean queue length"
label.mechanism <- "Mechanism"
label.normalized.threshold <- expression(paste("Normalized synchronization threshold ", T[n],  " (s)"))
label.number.of.stalling.events <- 'Number of stalling events'
label.qoe.model <- 'QoE Model'
label.stalling.duration <- 'Stalling duration per event (s)'
label.time <- 'Time t (s)'
label.buffer <- 'Buffer size S'
label.unplayed.buffer <- expression(paste("Buffer ", t[u](t), " (s)"))
label.bitrate <- expression(paste('Video bit rate ', b[r], ' ', (Mbit^-1)))
label.energy <- 'Energy consumption E (kJ)'
label.wasted.traffic <- 'Wasted traffic W (Mbit)'
label.user.model <- 'User model'
label.connections <- 'Connection count C'
label.buffer.lower <- expression(paste("Stop threshold ", theta))
label.buffer.size <- expression(paste("Buffer size ", Theta))
label.abort.time <- 'Abort time t (s)'
label.pdf.abort.time <- 'PDF A(t)'

#
label.user.model <- 'User model'
label.playback.status <- 'Playback status'
label.finite <- 'Video browsing'
label.infinite <- 'Steady state'
label.offered.load <- 'Offered load'
label.alpha <- expression(paste("Duration Parameter ", alpha)) 
label.beta <- expression(paste("Interruption Parameter ", beta)) 
label.prebuffering.sensitivity <- expression(paste("Pre-buffering Parameter ", gamma))
label.normalized.video.buffer <- expression(paste('Normalized Video Buffer ', d^'*', ' (s)'))

# 4.2, done
label.power <- 'Power drain E (kW)'
label.pareto <- 'Pareto optimal'
label.number.servers <- 'Number of available servers n+m'
label.parameter <- 'Parameter'
label.waiting.time.ms <- "Mean waiting Time E[W] (ms)"

# 4.3
label.tunnel.iat <- 'Tunnel inter-arrival time t (s)'
label.cdf.iat <- expression(P(T <= t))
label.distribution <- 'Distribution'
label.tunnel.duration <- 'Tunnel duration d (s)'
label.cdf.duration <- expression(P(D <= d))
label.number.instances <- 'Active instances I'
label.cdf.number.instances <- expression(P(I <= i))
label.max.instances <- expression(paste('Maximum number of active instances ', S[max]))
label.max.tunnels <- expression(paste('Maximum number of tunnels ', n))
label.blocking.probability <- expression(paste('Blocking probability ', p[B]))
label.mean.resource.utilization <- expression(paste('Mean number of active tunnels')) 
label.startstop.duration <- expression(paste('Start-up and shut-down time ', (s)))

# 4.4, done
label.campaign.interarrival <- expression('Campaign inter-arrival time A'[c]*' (h)')
label.cdf.campaign.interarrival <- expression(P(A[c] <= t))
label.campaign.size <- expression(paste('Campaign size ', Theta))
label.cdf.campaign.size <- expression(P(T <= Theta))
label.number.of.workers <- 'Number of workers c'
label.worker.utilization <- expression(paste('Worker utilisation ', rho))
label.mean.task.length <- 'Mean task length E[B] (s)'
label.mean.task.delay <- 'Task pre-processing Delay E[D] (s)'
label.campaign.arrival.distribution <- 'Campaign arrival'
label.campaign.rate <- expression(paste('Rate ', beta))

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
