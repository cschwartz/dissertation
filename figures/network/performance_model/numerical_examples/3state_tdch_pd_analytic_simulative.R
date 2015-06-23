data <- read.csv('3state_tdch_pd_analytic_simulative.csv', sep=',', comment.char='#')

data$evaluation.type <- factor(data$evaluation.type, labels = c('Model', 'Simulation'))
data$app <- factor(data$app, labels = c('Mail', 'Twitter'))

p <- ggplot(data, aes(x = tdch, 
                      y = power.drain, 
                      color = app,
                      linetype = evaluation.type)) + 
  geom_line() +
  scale_color_manual(values = color.palette) +
  labs(x = label.tdch, 
       y = label.power.drain, 
       color = label.application, 
       linetype = label.evaluation.type )

save.full.row.plot(p) 