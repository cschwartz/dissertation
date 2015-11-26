data <- read.csv('3_state_signalling_vs_power_consumption.csv', sep=',', comment.char='#')

data$application <- factor(data$application, labels = c('Angry Birds', 'Aupeo', 'Twitter', 'Skype'))

p <- ggplot(data, aes(x = signalling.intensity,
                      y = power.drain,
                      color = tdch,
                      group=application)) + 
  geom_point() +
  geom_point(data = subset(data, tdch == 11), color = color.highlight) +
  geom_path(color=color.highlight) +
  facet_wrap(~ application, ncol = 2) +
  scale_color_continuous(low = color.low, high = color.high) +
  labs(x = label.signalling.frequency, 
       y = label.power.drain, 
       color = label.tdch,
       shape = label.application ) +
  guides(shape = guide_legend(order = 1),
         colour = guide_colorbar(order = 2))

save.full.row.plot(p)