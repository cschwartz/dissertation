data <- read.csv('video_model_bandwidth.csv')
data <- droplevels(subset(data, type != 'Provisioning'))

t.start <- 5
bandwidth <- 100

plot.animation <- function(elements) {
  p <- ggplot(subset(data, type %in% elements), aes(x = time,
                      y = value,
                      color = type)) + 
  geom_step() +
  scale_colour_manual(values = color.palette, drop=F) +
  coord_cartesian(xlim = c(0, 260)) +
  scale_x_continuous(breaks = c(0, t.start, seq(50, 250, 50)), labels = c(0, expression(sigma), seq(50, 250, 50))) +
  scale_y_continuous(breaks = c(0, bandwidth), labels = c(0, "   bW")) +
  labs(x = label.time,
       y = label.bandwidth.at.time.t,
       colour = label.mechanism)
  
  save.full.row.plot(p, paste(elements, collapse="_"))
}

plot.animation(c('Download'))
plot.animation(c('Download', 'Live'))
plot.animation(c('Download', 'Live', 'Streaming'))