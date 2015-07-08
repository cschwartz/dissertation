data <- read.csv('qoe_with_backgroundapp_twitter.csv', sep=',', comment.char='#')

data$tdch <- factor(data$tdch)

p <- ggplot(data, aes(x = page.load.time,
                      y = qoe,
                      color = tdch)) + 
  geom_line() +
  scale_color_manual(values = color.palette) +
  labs(x = label.page.load.time, 
       y = label.qoe, 
       color = label.tdch )

save.full.row.plot(p)