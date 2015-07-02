data <- read.csv('interarrival_times.csv', sep=',', comment.char='#')

data$application <- factor(data$application, labels = c('Angry Birds', 'Aupeo', 'Twitter', 'Skype'))

p <- ggplot(data, aes(x = interarrival.time, 
                      color = application)) + 
  stat_ecdf(n = 100) +
  scale_x_log10() +
  scale_color_manual(values = color.palette) +
  labs(x = label.interarrival.time, 
       y = label.interarrival.time.cdf, 
       color = label.application )

save.full.row.plot(p)