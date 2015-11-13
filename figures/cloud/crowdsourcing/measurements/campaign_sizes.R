data <- read.csv('campaign_sizes.csv')
data$type <- factor(data$type, labels = c('Measurement','Fitting'))

p <- ggplot(data, aes(x, color=type)) +
  stat_ecdf() + 
  scale_x_continuous(limits = c(0, 600)) +
  scale_y_continuous() +
  scale_color_manual(values = color.palette) +
  labs(x = label.campaign.size,
       y = label.cdf.campaign.size,
       color = label.type)

save.full.row.plot(p)