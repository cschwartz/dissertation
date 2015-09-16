data <- read.csv('bitrate2connections_parameters.csv')

data$buffer.lower <- factor(data$buffer.lower)
data$buffer.size <- factor(data$buffer.size)

p <- ggplot(data,
            aes(x = bitrate,
                y = connections,
                color = buffer.size,
                shape = buffer.lower)) +
  geom_line() +
  geom_point() +
  scale_x_continuous(breaks = as.integer(unique(data$bitrate))) +
  scale_y_continuous(limits = c(0, 100)) +
  scale_colour_manual(values = color.palette) +
  labs(x = label.bitrate, 
       y = label.connections, 
       colour = label.buffer.size,
       shape = label.buffer.lower)

save.full.row.plot(p)