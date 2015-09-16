data <- read.csv('connections2lostData_all.csv')
data.pareto <- read.csv('connections2lostData_pareto.csv')

data$buffer.size <- factor(data$buffer.size)
data$buffer.lower <- factor(data$buffer.lower)
data$bitrate <- factor(data$bitrate)

p <- ggplot(data) +
  geom_line(data = data.pareto, aes(x = connections,
                                    y = wasted.data)) +
  geom_point(aes(x = connections,
                 y = wastedTraffic,
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