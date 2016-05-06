data <- read.csv('video_model_playback.csv')
data <- droplevels(subset(data, type != 'Provisioning'))

t.min <- 20
t.max <- 45
t.start <- 5
bandwidth <- 100

plot.animation <- function(elements) {
p <- ggplot(subset(data, type %in% elements), aes(x = time,
                      y = value,
                      color = type)) +
  geom_line() +
  scale_colour_manual(values = color.palette, drop=F) +
  scale_y_continuous(breaks = c(0, t.min, t.max), labels = c(0, expression(theta), expression(theta + Theta))) +
  scale_x_continuous(breaks = c(0, t.start, seq(50, 250, 50)), labels = c(0, expression(sigma), seq(50, 250, 50))) +
  coord_cartesian(xlim = c(0, 260))+
  labs(x = label.time, y = label.unplayed.buffer, colour = label.mechanism)

  save.full.row.plot(p, paste(elements, collapse="_"))
}

plot.animation(c('Download'))
plot.animation(c('Download', 'Live'))
plot.animation(c('Download', 'Live', 'Streaming'))
