data <- read.csv('blocking_comparison.csv')
data$max.tunnels <- factor(data$max.tunnels)

p <- ggplot(data, aes(x = max.tunnels,
                      y = relative.blocking.probability,
                      ymin = relative.blocking.probability.min,
                      ymax = relative.blocking.probability.max)) +
  geom_bar(aes(fill = max.tunnels), stat = 'identity') +
  geom_errorbar(width = 0.5) +
  scale_fill_manual(values = color.palette, guide = F) +
  labs(x = label.max.tunnels,
       y = label.relative.blocking.probability)

save.full.row.plot(p)



