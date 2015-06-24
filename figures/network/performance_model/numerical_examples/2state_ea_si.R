data <- read.csv('2state_ea_si.csv', sep=',', comment.char='#')

data$cA <- factor(data$cA)

p <- ggplot(data, aes(x = EA, 
                      y = SI, 
                      color = cA)) + 
  geom_line() +
  scale_x_log10() +
  scale_color_manual(values = color.palette) +
  labs(x = label.ea, 
       y = label.signalling.intensity, 
       color = label.cA )

save.full.row.plot(p)