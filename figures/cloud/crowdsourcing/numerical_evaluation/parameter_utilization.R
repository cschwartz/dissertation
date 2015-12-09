data <- read.csv('parameter_utilization.csv')
data$EB <- factor(data$EB * 60)

data <- subset(data, data$EB != 60 & data$shape != '1/0.484071')

p <- ggplot(data, aes(x=n, color=EB)) + 
  geom_line(data = data, aes(x=n, y=mean.utilization*60, color=EB)) +
  geom_errorbar(data = data, aes(x=n, ymin=(mean.utilization-ci)*60, ymax=(mean.utilization+ci)*60, color=EB),
                width=.2) +
  scale_color_manual(values = color.palette, guide = guide_legend(order=1, nrow = 2)) +
  facet_grid(rate ~ shape) +
  labs(x = label.number.of.workers, 
       y = label.worker.utilization, 
       color=label.mean.task.length)

save.full.row.plot(p)