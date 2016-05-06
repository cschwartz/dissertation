setwd('~/Documents/paper/dissertation/figures')
source('plot_settings.R')

diss.base <- '~/Documents/paper/dissertation/figures'
presentation.base <- '~/Dropbox/Dissertation/figures'

label.tdch <- expression(paste('Netztimer ', T[DCH], ' ', (s)))
label.signalling.frequency <- 'Signalisierungsfrequenz'
label.power.drain <- 'Leistungsaufnahme'
label.application <- 'Anwendung'

label.time <- 'Zeit (s)'
label.unplayed.buffer <- 'Pufferlänge (s)'
label.bandwidth.at.time.t <- expression(paste("Bandbreite (", Mbit^-1, ")"))
label.mechanism <- 'Mechanismus'

label.abort.time <- 'Abbruchzeit (s)'
label.pdf.abort.time <- 'PDF a(t)'
label.user.model <- 'Nutzer'

label.bitrate <- expression(paste('Video Bitrate ', (Mbit^-1)))
label.wasted.traffic <- 'Resourcenverbrauch'

label.energy <- 'Energieverbrauch (kJ)'
label.buffer.lower <- expression(paste("Untere Pufferschranke ", theta))
label.buffer.size <- expression(paste("Pufferlänge ", Theta))

label.number.of.stalling.events <- 'Anzahl Unterbrechungen'
label.stalling.duration <- 'Mittlere Dauer pro Unterbrechung (s)'
label.qoe <- 'Mean Opinion Score'

label.buffer <- 'Pufferlänge (s)'
label.playback.status <- 'Zustand'
label.stalling <- 'Wartend'
label.playing <- 'Abspielend'

label.normalized.video.buffer <- 'Normalisierte Pufferlänge (s)'
label.alpha <- expression(paste("Längenparameter ", alpha)) 
label.beta <- expression(paste("Häufigkeitsparameter ", beta)) 

plots <- c('network/network_traces/numerical_results/3_state_tdch_vs_frequency_deutsch',
           'network/network_traces/numerical_results/3_state_tdch_vs_power_drain_deutsch',
           'application/lte_video/system_model/video_model_playback_animation',
           'application/lte_video/system_model/video_model_bandwidth_animation',
           'application/lte_video/system_model/abort_distributions',
           'application/lte_video/numerical_evaluation/bitrate2lostData_deutsch',
           'application/lte_video/trade_offs/energy2lostData_deutsch',
           'application/lte_video/system_model/stalling2qoe_deutsch',
           'application/qoe_user_behaviour/system_model/player',
           'application/qoe_user_behaviour/system_model/comparison',
           'application/qoe_user_behaviour/user_scenarios/default_scenario_deutsch')

for (plot.name in plots) {
  print(plot.name)
  source.name <- paste(file.path(diss.base, plot.name), 'R', sep='.')
  
  save.full.row.plot <- function(plot, filename.appendix = NA) {
    plot <- plot + plot_options + theme(legend.box = "vertical")
    
    if(is.na(filename.appendix)) {
      destination.name <- paste(file.path(presentation.base, basename(plot.name)), 'pdf', sep='.')
    } else {
      destination.name <- paste(file.path(presentation.base, basename(plot.name)), filename.appendix, 'pdf', sep='.')
    }
    ggsave(destination.name, plot=plot,height = rowHeight, width = pageWidth, units = units, device='pdf')
  }
  
  setwd(dirname(plot.name))
  source(source.name)
  setwd(diss.base)  
}

