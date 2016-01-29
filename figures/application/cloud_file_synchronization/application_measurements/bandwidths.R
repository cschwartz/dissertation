data <- read.csv('bandwidths.csv')

p <- ggplot(data %>% sample_frac(0.25), aes(x = bandwidth / 1024 / 1024, color = direction, linetype=type)) +
  stat_ecdf() +
  scale_x_continuous(limits = c(0, 20)) +
  scale_colour_manual(values = color.palette) +
  labs(x = label.bandwidth, 
       y = label.cdf.bandwidth, 
       color = label.direction,
       linetype = label.type)

save.full.row.plot(p)