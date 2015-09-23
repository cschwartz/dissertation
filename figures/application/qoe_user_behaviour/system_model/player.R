require(ggplot2)

data <- data.frame(phase.start = c(0, 1, 3, 4, 8, 8.5),
                   phase.end = c(1, 3, 4, 6, 8.5, 9.16),
                   buffer.start = c(0, 1, 3, 1, 3, 2), 
                   buffer.end = c(1, 3, 1, 3, 2, 0),
                   status = c('Stalling', 'Stalling', 'Playing', 'Stalling', 'Playing', 'Playing'))

data$status <- factor(data$status)

p <- ggplot(data, aes(x = phase.start, xend = phase.end,
                      y = buffer.start, yend = buffer.end,
                      color = status)) + 
  geom_segment() +
  geom_point() +
  annotate("text", x = 1.9, y = 2, label = 'lambda') + 
  annotate("text", x = 4.7, y = 2, label = 'mu - lambda') +   
  annotate("text", x = 9.5, y = 2.5, label = 'mu - lambda') + 
  annotate("text", x = 9.5, y = 1, label = 'mu') +     
  scale_x_continuous(breaks = c(0, 1, 3, 4, 8, 8.5, 9.16),
                     labels = c(expression(t[0]), expression(t[1]), expression(t[2]), expression(t[3]), expression(t[2 * N]), expression(t[Z]), expression(t[E]))) + 
  scale_y_discrete(breaks = c(1, 3), labels = c('p', 'q')) +
  scale_colour_manual(values = color.palette) + 
  labs(x = label.time,
       y = label.buffer,
       color = label.playback.status)

save.full.row.plot(p)