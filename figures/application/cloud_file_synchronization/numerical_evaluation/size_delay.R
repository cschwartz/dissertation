data <- read.csv('results_size.csv')

parameters <- 2^c(0:9)
upper.bound.delay <- 1100

p <- ggplot(data, aes(x=size.threshold, y = mean.life.time, color = mechanism)) +
  stat_summary(fun.data = mean_cl_boot, geom="errorbar") +
  stat_summary(fun.y = mean, geom="line") +
  scale_x_log10(breaks = parameters) +
  scale_color_manual(values = color.palette) + 
  coord_cartesian(ylim = c(0, upper.bound.delay)) +
  labs(x = label.size.threshold,
       y = label.waiting.time,
       color = label.mechanism)

save.full.row.plot(p)