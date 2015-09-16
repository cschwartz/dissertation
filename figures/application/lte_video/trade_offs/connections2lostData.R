data <- read.csv('connections2lostData_all.csv')
data.pareto <- read.csv('connections2lostData_pareto.csv')

data$buffer.size <- factor(data$buffer.size)
data$buffer.lower <- factor(data$buffer.lower)
data$bitrate <- factor(data$bitrate, levels = c('2','6', '10'))
data.pareto$bitrate <- factor(data.pareto$bitrate, levels = c('2','6', '10'))

annotation_data <- data.frame(bitrate = factor(c(6, 10), levels = c(6, 10)), wasted.data = c(35.5150, 59.3029), connections = 1, xtextpos = c(40.0, 65), ytextpos = c(15, 35), text = "Pareto Optimum")

p <- ggplot(data) +
  geom_line(data = data.pareto, aes(x = wasted.data,
                                    y = connections)) +
  geom_point(aes(x = wasted.data,
                 y = connections,
                 color = buffer.lower,
                 shape = buffer.size)) +
  facet_grid(. ~ bitrate, scale = "free") +
  labs(x = label.connection.count,
       y = label.wasted.traffic,
       color = label.buffer.lower,
       shape = label.buffer.size) +
  geom_text(data = annotation_data, aes(x = xtextpos, y = ytextpos), label = "Pareto Optimum", size = 2, vjust = 0, hjust = 0) +
  geom_segment(data = annotation_data, aes(x = xtextpos, xend = wasted.data, y = ytextpos, yend = connections), arrow = arrow(length = unit(0.1, "cm"))) +
  scale_color_manual(values = color.palette) +
  guides(shape = guide_legend(order = 2), color=guide_legend(order = 1))

save.full.row.plot(p)
