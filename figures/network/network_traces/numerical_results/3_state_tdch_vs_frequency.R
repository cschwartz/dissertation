data <- read.csv('3_state_tdch_vs_frequency.csv', sep=',', comment.char='#')

data$application <- factor(data$application, labels = c('Angry Birds', 'Aupeo', 'Twitter', 'Skype'))

p <- ggplot(data, aes(x = tdch,
                      y = signalling.intensity,
                      color = application)) + 
  geom_line() +
  scale_color_manual(values = color.palette) +
  labs(x = label.tdch, 
       y = label.signalling.intensity, 
       color = label.application )

save.full.row.plot(p)