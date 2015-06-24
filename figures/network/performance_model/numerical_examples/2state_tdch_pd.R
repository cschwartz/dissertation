data <- read.csv('2state_tdch_pd.csv', sep=',', comment.char='#')

data$cA <- factor(data$cA)

p <- ggplot(data, aes(x = TDCH, 
                      y = PD, 
                      color = cA)) + 
  geom_line() +
  scale_color_manual(values = color.palette) +
  labs(x = label.tdch, 
       y = label.power.drain, 
       color = label.cA )

save.full.row.plot(p)