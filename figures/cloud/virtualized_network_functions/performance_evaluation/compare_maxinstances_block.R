data <- read.csv('compare_maxinstances_block.csv')
data$max.instances <- factor(data$max.instances)
data$max.tunnels <- factor(data$max.tunnels)
data$startstop.duration <- factor(data$startstop.duration)

p <- ggplot(data, aes(x = max.tunnels,
                      y = block.prob,
                      group = startstop.duration,
                      ymin = block.prob - ci,
                      ymax = block.prob + ci)) +
  geom_line(aes(color = startstop.duration)) +
  geom_errorbar(width = 0.1) +
  scale_x_discrete() +
  scale_colour_manual(values = color.palette) +
  labs(x = label.max.tunnels,
       y = label.blocking.probability,
       color = label.startstop.duration)

save.full.row.plot(p)


