data <- read.csv('comparison_task_delay.csv')
data$EB <- factor(data$EB * 60)

p <- ggplot(data, aes(x=n, color=EB, linetype=type)) + 
  geom_line(data = data, aes(x=n, y=mean.waiting.time * 60, color=EB)) +
  geom_errorbar(data = data, aes(x=n, ymin=(mean.waiting.time-ci) * 60, ymax=(mean.waiting.time+ci) * 60, color=EB),
                width=.2) +
  scale_color_manual(values = color.palette, guide = guide_legend(order=1, nrow = 2)) +
  scale_y_continuous(breaks = seq(0, 750, by = 250)) +
  labs(x = label.number.of.workers, 
       y = label.mean.task.delay, 
       color=label.mean.task.length,
       linetype=label.distribution) +
  coord_cartesian(xlim = c(5, 26), ylim = c(0, 760))

save.full.row.plot(p)