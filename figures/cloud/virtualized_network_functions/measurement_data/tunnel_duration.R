data <- read.csv('tunnel_duration.csv')
data$origin <- factor(data$origin)

p <- ggplot(data, aes(x = x,
                      y = y,
                      color= origin)) +
  geom_line() +
  facet_wrap(~ timeslot) +
  scale_x_log10(labels = notation.si) +
  scale_color_manual(values = color.palette) +
  labs(x = label.tunnel.duration,
       y = label.cdf.duration,
       color = label.distribution) +
  coord_cartesian(xlim = c(1, 1.5e6))

save.full.row.plot(p)

