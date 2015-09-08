data <- read.csv('image_size.csv')

p <- ggplot(data, aes(x = image.size / 1024 / 1024, color=type)) +
  stat_ecdf() + 
  scale_x_log10(limits = c(1, 25), name = label.size, breaks = c(1, 2, 4, 8, 16)) +
  scale_colour_manual(values = color.palette) +
  labs(x = label.image.size, 
       y = label.cdf.image.size, 
       color = label.type )

save.full.row.plot(p)