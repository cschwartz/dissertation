data <- read.csv('compare_util_block.csv')
data$max.instances <- factor(data$max.instances)
data$max.tunnels <- factor(data$max.tunnels)
data$startstop.duration <- factor(data$startstop.duration)

p <- ggplot(data, aes(x = res.util,
                      y = block.prob,
                      shape = max.tunnels,
                      color = startstop.duration)) +
  geom_point() +
  facet_grid(~ max.instances) +
  scale_x_continuous() +
  scale_y_log10() +
  scale_shape_manual(values = seq(1, 7)) +
  scale_colour_manual(values = color.palette) +
  labs(x = label.mean.resource.utilization,
       y = label.blocking.probability,
       color = label.startstop.duration,
       shape = label.max.tunnels)

save.full.row.plot(p)

