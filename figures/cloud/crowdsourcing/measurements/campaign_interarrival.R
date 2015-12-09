data <- read.csv('campaign_interarrival.csv')
data$type <- factor(data$type, labels = c('Measurement','Fitting'))

p <- ggplot(data, aes(x, color=type)) +
  stat_ecdf() + 
  scale_x_continuous(limits = c(0,2)) +
  scale_y_continuous() +
  scale_color_manual(values = color.palette) +
  labs(x = label.campaign.interarrival,
       y = label.cdf.campaign.interarrival,
       color = label.type) +
  coord_cartesian(xlim = c(0, 1.26))

save.full.row.plot(p)