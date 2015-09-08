data <- read.csv('bandwidths.csv')

bandwidth.plot <- ggplot(melted.bandwidth, aes(x = value / 1024 / 1024, color = variable, linetype=Type)) +
  stat_ecdf() +
  scale_x_continuous(name = label.bandwidth, limits = c(0, 20)) +
  scale_y_continuous(name = label.cdf.bandwidth) +
  scale_colour_manual(name = "Bandwidth", values = colorPalette)