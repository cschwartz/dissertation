data <- read.csv('bitrate2connections.csv')

p <- ggplot(data,
            aes(x = bitrate,
                y = connections,
                color = mechanism)) +
  geom_line() +
  geom_point() +
  scale_x_continuous(breaks = as.integer(unique(data$bitrate))) +
  scale_y_continuous(limits = c(0, 50)) +
  scale_colour_manual(values = color.palette) +
  labs(x = label.bitrate, 
       y = label.connections, 
       colour = label.mechanism)

save.full.row.plot(p)