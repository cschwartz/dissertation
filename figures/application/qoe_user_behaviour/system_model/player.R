data <- data.frame(phase.start = c(0, 1, 3, 4, 8, 8.5),
                   phase.end = c(1, 3, 4, 6, 8.5, 9.16),
                   buffer.start = c(0, 1, 3, 1, 3, 2), 
                   buffer.end = c(1, 3, 1, 3, 2, 0),
                   status = c('Stalling', 'Stalling', 'Playing', 'Stalling', 'Playing', 'Playing'))

data$status <- factor(data$status)

arrow.color <- 'black'
arrow.properties <- arrow(length = unit(0.1, "cm"), ends = 'both')
arrow.distance <- 0.1

p <- ggplot(data, aes(x = phase.start, xend = phase.end,
                      y = buffer.start, yend = buffer.end,
                      color = status)) + 
  geom_segment() +
  geom_point() +
  annotate("text", x = 1.7, y = 2, label = 'lambda', parse = T, size = annotation.font.size) + 
  annotate("text", x = 3.85, y = 2, label = 'mu - lambda', parse = T, size = annotation.font.size) +   
  annotate("text", x = 8.65, y = 2.5, label = 'mu - lambda', parse = T, size = annotation.font.size) + 
  annotate("text", x = 9, y = 1, label = 'mu', parse = T, size = annotation.font.size) +     
  annotate("text", x = 7, y = 3, label = '...', parse = T, size = annotation.font.size) +
  annotate("segment", x = 3, y = 1+arrow.distance, xend = 3, yend = 3-arrow.distance, color = arrow.color, arrow = arrow.properties, show_guide = F) +
  annotate("segment", x = 1+arrow.distance, y = 1, xend = 3-arrow.distance, yend = 1, color = arrow.color, arrow = arrow.properties, show_guide = F) +
  annotate("text", x = 2, y = 0.8, label = 'L', parse = T, size = annotation.font.size) +     
  annotate("text", x = 2.8, y = 2, label = 'd', parse = T, size = annotation.font.size) +
  scale_x_continuous(breaks = c(0, 1, 3, 4, 8, 8.5, 9.16),
                     labels = c(expression(t[0]), expression(t[1]), expression(t[2]), expression(t[3]), expression(t[2 * N]), expression(t[Z]), expression(t[E]))) + 
  scale_y_discrete(breaks = c(1, 3), labels = c('q', 'p')) +
  scale_colour_manual(values = color.palette) + 
  labs(x = label.time,
       y = label.buffer,
       color = label.playback.status) +
  coord_cartesian(ylim = c(0, 3.5)) 

save.full.row.plot(p)