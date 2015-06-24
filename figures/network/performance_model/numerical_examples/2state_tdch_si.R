data <- read.csv('2state_tdch_si.csv', sep=',', comment.char='#')

data$cA <- factor(data$cA)

p <- ggplot(data, aes(x = TDCH, 
                      y = SI, 
                      color = cA)) + 
  geom_line() +
  scale_color_manual(values = color.palette) +
  labs(x = label.tdch, 
       y = label.signalling.intensity, 
       color = label.cA )

save.full.row.plot(p)