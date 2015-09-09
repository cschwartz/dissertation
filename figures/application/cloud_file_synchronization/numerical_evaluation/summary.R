data <- read.csv('summary.csv')

p <- ggplot(data, aes(x = mean.relative.disconnected.time * 100, y = mean.waiting.time, size = mean.connected.count, color = mechanism)) +
  geom_point() +
  scale_size_continuous(range = c(2, 5)) +
  scale_color_manual(values = color.palette, guide = F) +
  labs(x = label.disconnection.time,
       y = label.waiting.time,
       size = label.connection.count)

save.full.row.plot(p)