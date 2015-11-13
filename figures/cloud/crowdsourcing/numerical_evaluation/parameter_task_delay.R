data <- read.csv('parameter_task_delay.csv')
data$EB <- factor(data$EB * 60)

p <- ggplot(data, aes(x=n, color=EB)) + 
  geom_line(data = data, aes(x=n, y=mean.waiting.time*60, color=EB)) +
  geom_errorbar(data = data, aes(x=n, ymin=(mean.waiting.time-ci)*60, ymax=(mean.waiting.time+ci)*60, color=EB),
                width=.2) +
  scale_y_log10(labels = notation.si) +
  scale_color_manual(values = color.palette, guide = guide_legend(order=1, nrow = 2)) +
  facet_grid(rate ~ shape) +
  labs(x = label.number.of.workers, 
       y = label.mean.task.delay, 
       color=label.mean.task.length)

save.full.row.plot(p)