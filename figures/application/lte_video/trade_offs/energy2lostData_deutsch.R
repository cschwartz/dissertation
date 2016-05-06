data <- read.csv('energy2lostData_all.csv')
data.pareto <- read.csv('energy2lostData_pareto.csv')

data$buffer.size <- factor(data$buffer.size)
data$buffer.lower <- factor(data$buffer.lower)
data$bitrate <- factor(data$bitrate, levels = c('2', '6', '10'))
data.pareto$bitrate <- factor(data.pareto$bitrate, levels = c('2', '6', '10'))

data <- subset(data, bitrate == 2)
data.pareto <- subset(data.pareto, bitrate == 2)
labeller.bitrate <- function(unit) {
#  passed.unit <- substitute(unit)
  
#  function(v) {
#    #print(v)
#    do.call(expression, lapply(levels(v)[v], function(v) {
#      bquote(paste(.(v), ' ', .(passed.unit)))
#    }))
#  }
  function(v) {
    do.call(expression, lapply(levels(v['bitrate',]), function(vprime) {
      bquote(paste(.(vprime), ' ', .(substitute(passed.unit))))
    }))
  }
}

p <- ggplot(data) +
  geom_line(data = data.pareto, aes(x = wasted.data,
                              y = power)) +
  geom_point(aes(x = wasted.data,
                 y = power,
                 color = buffer.lower,
                 shape = buffer.size)) +
  #facet_grid(. ~ bitrate, scale = "free", labeller = labeller.bitrate((Mbit^-1))) +
   labs(x = label.wasted.traffic,
        y = label.energy,
        color = label.buffer.lower,
        shape = label.buffer.size) +
   scale_color_manual(values = color.palette) +
   guides(shape = guide_legend(order = 2), color=guide_legend(order = 1))

save.full.row.plot(p)