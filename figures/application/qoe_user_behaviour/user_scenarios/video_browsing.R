source('qoe_model.R')

variables <- expand.grid(alpha = -0.15, 
                         beta = -0.2,
                         B = seq(0.01, 10, by = 0.01),
                         a = c(0.95, 0.6),
                         gamma = c(0.3, 0.6),
                         lambda = 1,
                         T = 10)


data <- ddply(variables, .(qoe.infinite = qoe.infinite(B, a, lambda, alpha, beta, gamma),
                           qoe.finite = qoe.finite(B, a, lambda, T, alpha, beta, gamma)))

data$a <- factor(data$a)
data$gamma <- factor(data$gamma)

molten.data <- melt(data, measure.vars = c('qoe.infinite', 'qoe.finite'))
molten.data$variable <- factor(molten.data$variable, 
                               levels = c('qoe.finite', 'qoe.infinite'),
                               labels  = c(label.finite, label.infinite))

p <- ggplot(molten.data, aes(x = B, y = value, color = a, linetype = variable)) +
  geom_line() +
  facet_grid(. ~ gamma) +
  scale_colour_manual(values = color.palette, name = label.offered.load) +
  scale_x_continuous(name = label.buffer) +
  scale_y_continuous(name = label.qoe) +
  scale_linetype_discrete(name = label.type) +
  guides(colour = guide_legend(order = 1),
         linetype = guide_legend(order = 2))

save.full.row.plot(p)
