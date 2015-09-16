data <- read.csv('bitrate2energy.csv')

p <- ggplot(data,
            aes(x = bitrate,
                y = power,
                color = mechanism)) +
  geom_line() +
  geom_point() +
  scale_x_continuous(breaks = as.integer(unique(data$bitrate))) +
  scale_y_continuous(limits = c(0, 3)) +
  scale_colour_manual(values = color.palette) +
  labs(x = label.bitrate, 
       y = label.energy, 
       colour = label.mechanism)

save.full.row.plot(p)