data <- read.csv('autocorrelation.csv', sep=',', comment.char='#')

data$application <- factor(data$application, labels = c('Angry Birds', 'Aupeo', 'Twitter', 'Skype'))

p <- ggplot(data, aes(x = lag,
                      y = autocorrelation,
                      fill = application)) + 
  geom_bar(position='dodge', stat='identity') +
  scale_fill_manual(values = color.palette) +
  labs(x = label.lag, 
       y = label.interarrival.sample.autocorrelation, 
       fill = label.application )

save.full.row.plot(p)