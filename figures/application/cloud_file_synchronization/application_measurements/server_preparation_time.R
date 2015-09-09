data <- read.csv('server_preparation_time.csv')

p <- ggplot(data, aes(x = server.preparation.time, color = type)) +
  stat_ecdf() +
  scale_x_log10(limits = c(1, 15), breaks = c(1, seq(2, 10, 2))) +
  scale_colour_manual(values = color.palette) +
  labs(x = label.server.preparation.time, 
       y = label.cdf.server.preparation.time, 
       color = label.type )

save.full.row.plot(p)