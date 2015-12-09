data <- read.csv('pareto.csv')
data$EB <- factor(data$EB * 60)
data$n <- factor(data$n)
data$rate <- factor(data$rate)

data <- subset(data, data$EB != 60)

p <- ggplot(data, aes(x=mean.utilization, y=mean.waiting.time, color=n)) + 
  geom_line(aes(group = n)) +
  geom_point(aes(shape = rate)) +
  scale_y_log10(labels = notation.si) +
  scale_color_manual(values = color.palette, guide = guide_legend(order=1, nrow = 2)) +
  facet_grid(. ~ EB) +
  labs(x = label.worker.utilization, 
       y = label.mean.task.length, 
       color=label.number.of.workers,
       shape=label.campaign.rate)

save.full.row.plot(p)