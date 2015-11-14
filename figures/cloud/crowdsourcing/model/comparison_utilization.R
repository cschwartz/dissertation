data <- read.csv('comparison_utilization.csv')
data$EB <- factor(data$EB * 60)

p <- ggplot(data, aes(x=n, color=EB, linetype=type)) + 
  geom_line(data = data, aes(x=n, y=mean.utilization, color=EB)) +
  geom_errorbar(data = data, aes(x=n, ymin=mean.utilization-ci, ymax=mean.utilization+ci, color=EB),
                width=.2) +
  scale_color_manual(values = color.palette, guide = guide_legend(order=1, nrow = 2)) +
  labs(x = label.number.of.workers, 
       y = label.worker.utilization, 
       color=label.mean.task.length,
       linetype=label.distribution)

save.full.row.plot(p)