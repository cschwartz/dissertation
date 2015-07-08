data <- read.csv('3_state_tdch_vs_power_drain.csv', sep=',', comment.char='#')

data$application <- factor(data$application, labels = c('Angry Birds', 'Aupeo', 'Twitter', 'Skype'))

p <- ggplot(data, aes(x = tdch,
                      y = power.drain,
                      color = application)) + 
  geom_line() +
  scale_color_manual(values = color.palette) +
  labs(x = label.tdch, 
       y = label.power.drain, 
       color = label.application )

save.full.row.plot(p)