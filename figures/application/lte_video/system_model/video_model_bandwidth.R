data <- read.csv('video_model_bandwidth.csv')

t.start <- 5
bandwidth <- 100

p <- ggplot(data, aes(x = time,
                      y = value,
                      color = type)) + 
  geom_step() +
  scale_colour_manual(values = color.palette) +
  coord_cartesian(xlim = c(0, 260)) +
  scale_x_continuous(breaks = c(0, t.start, seq(50, 250, 50)), labels = c(0, expression(sigma), seq(50, 250, 50))) +
  scale_y_continuous(breaks = c(0, bandwidth), labels = c(0, "   bW")) +
  labs(x = label.time,
       y = label.bandwidth.at.time.t,
       colour = label.mechanism)
  
save.full.row.plot(p)