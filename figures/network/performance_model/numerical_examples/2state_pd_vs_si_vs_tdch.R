data <- read.csv('2state_pd_vs_si_vs_tdch.csv', sep=',', comment.char='#')

data$cA <- factor(data$cA)

p <- ggplot(data, aes(x = SI, 
                      y = PD)) + 
  geom_point(aes(color = TDCH)) +
  geom_line(aes(linetype = cA)) +
  scale_color_continuous(low = color.low, high = color.high) +
  scale_linetype_manual(values = linetypes.for(data$cA)) +
  labs(x = label.signalling.intensity, 
       y = label.power.drain, 
       color = label.tdch )

save.full.row.plot(p)
