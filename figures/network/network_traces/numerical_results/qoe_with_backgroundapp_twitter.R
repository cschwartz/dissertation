data <- read.csv('qoe_with_backgroundapp_twitter.csv', sep=',', comment.char='#')

data$tdch <- factor(data$tdch)

p <- ggplot(data, aes(x = page.load.time,
                      y = qoe,
                      color = tdch)) + 
  geom_line() +
  scale_x_continuous(breaks = seq(0, 15, 3)) +
  scale_color_manual(values = color.palette) +
  labs(x = label.page.load.time, 
       y = label.qoe, 
       color = label.tdch ) +
  coord_cartesian(xlim = c(0, 16)) +
  expand_limits(x = c(0, 15))

save.full.row.plot(p)