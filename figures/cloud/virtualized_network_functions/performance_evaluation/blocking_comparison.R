data <- read.csv('blocking_comparison.csv')
data$max.instances <- factor(data$max.instances)

p <- ggplot(data, aes(x = max.instances,
                      y = blocking.probability,
                      ymin = blocking.probability - ci,
                      ymax = blocking.probability + ci)) +
  geom_bar(aes(fill = max.instances), stat = 'identity') +
  geom_errorbar(width = 0.5) +
  scale_fill_manual(values = color.palette, guide = F) +
  labs(x = label.max.instances,
       y = label.blocking.probability)

save.full.row.plot(p)