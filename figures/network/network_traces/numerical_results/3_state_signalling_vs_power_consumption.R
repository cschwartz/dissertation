data <- read.csv('3_state_signalling_vs_power_consumption.csv', sep=',', comment.char='#')

data$application <- factor(data$application, labels = c('Angry Birds', 'Aupeo', 'Twitter', 'Skype'))

p <- ggplot(data, aes(x = signalling.intensity,
                      y = power.drain,
                      shape = application,
                      color = tdch)) + 
  geom_point() +
  geom_point(data = subset(data, tdch == 11), color = color.highlight) +
  scale_color_continuous(low = color.palette[1], high = color.palette[2]) +
  labs(x = label.signalling.intensity, 
       y = label.power.drain, 
       color = label.tdch,
       shape = label.application ) +
  guides(shape = guide_legend(order = 1),
         colour = guide_colorbar(order = 2))

save.full.row.plot(p)