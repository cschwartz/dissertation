data <- read.csv('stalling2qoe.csv')

data$variable <- factor(data$variable)

p <- ggplot(data,
            aes(x = number.of.stalling.events,
                y = value,
                color = variable)) +
  geom_line() +
  geom_point(data = subset(data, data$number.of.stalling.events %in% seq(0, 6))) +
  scale_colour_manual(values = color.palette) +
  scale_y_continuous(breaks = seq(1, 5), labels = seq(1, 5), limits = c(1, 6)) +
  scale_x_continuous(breaks = seq(0, 6)) +
  labs(x = label.number.of.stalling.events, 
       y = label.qoe, 
       color = label.stalling.duration) +
  guides(colour = guide_legend(nrow = 2))
  
save.full.row.plot(p)
