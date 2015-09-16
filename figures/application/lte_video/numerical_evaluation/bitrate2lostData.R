data <- read.csv('bitrate2lostData.csv')

p <- ggplot(data,
            aes(x = bitrate,
                y = wasted.data,
                color = mechanism,
                linetype = user.model)) +
  geom_line() +
  geom_point() +
  scale_x_continuous(breaks = as.integer(unique(data$bitrate))) +
  scale_y_log10() +
  scale_colour_manual(values = color.palette) +
  labs(x = label.bitrate, 
       y = label.wasted.traffic, 
       colour = label.mechanism,
       linetype = label.user.model)

print(p)
#save.full.row.plot(p)