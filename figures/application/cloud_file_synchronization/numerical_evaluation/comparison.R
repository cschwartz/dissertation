data <- read.csv('comparison.csv')

parameters <- 2^c(0:9)

p <- ggplot(data, aes(x = parameter, y = connected.count, color = mechanism)) +
  stat_summary(fun.data = mean_cl_boot) +
  stat_summary(fun.y = mean, geom="line") +
  scale_x_log10(breaks = parameters) +
  scale_color_manual(values = color.palette) +
  labs(x = label.normalized.threshold,
       y = label.connection.count,
       color = label.mechanism)

save.full.row.plot(p)