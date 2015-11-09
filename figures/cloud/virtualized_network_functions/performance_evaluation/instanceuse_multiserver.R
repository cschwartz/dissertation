data <- read.csv('instanceuse_multiserver.csv')
data$max.tunnels <- factor(data$max.tunnels)
data$max.instances <- factor(data$max.instances)


p <- ggplot(data, aes(x = N,
                      y = mean,
                      ymin = q5,
                      ymax = q95)) +
  geom_line(aes(color = max.tunnels)) +
  geom_errorbar(width = 0.5) +
  facet_grid(max.instances ~ .) +
  scale_color_manual(values = color.palette) +
  labs(x = label.number.instances,
       y = label.cdf.number.instances,
       color = label.max.tunnels)

save.full.row.plot(p)


