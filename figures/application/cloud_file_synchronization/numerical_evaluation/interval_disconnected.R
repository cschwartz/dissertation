data <- read.csv('results_interval.csv')

parameters <- 2^c(0:9)
upper.bound.disconnected <- 26

p <- ggplot(data, aes(x = intervall.time, y = disconnected.time * 100, color = mechanism)) +
  stat_summary(fun.data = mean_cl_boot, geom="errorbar") +
  stat_summary(fun.y = mean, geom="line") +
  scale_x_log10(breaks = parameters) +
  scale_color_manual(values = color.palette) + 
  coord_cartesian(ylim = c(0, upper.bound.disconnected)) +
  labs(x = label.intervall.time,
       y = label.disconnection.time,
       color = label.mechanism)

save.full.row.plot(p)