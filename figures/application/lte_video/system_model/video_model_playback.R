data <- read.csv('video_model_playback.csv')

t.min <- 20
t.max <- 45
t.start <- 5
bandwidth <- 100

p <- ggplot(data, aes(x = time,
                      y = value,
                      color = type)) +
  geom_line() +
  scale_colour_manual(values = color.palette) +
  scale_y_continuous(breaks = c(0, t.min, t.max), labels = c(0, expression(theta), expression(theta + Theta))) +
  scale_x_continuous(breaks = c(0, t.start, seq(50, 250, 50)), labels = c(0, expression(sigma), seq(50, 250, 50))) +
  coord_cartesian(xlim = c(0, 260))+
  labs(x = label.time, y = label.buffer, colour = label.mechanism)

save.full.row.plot(p)

