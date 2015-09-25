source('qoe_model.R')

variables <- expand.grid(alpha = 0.15, 
                         beta = 0.2,
                         B = seq(0.01, 10, by = 0.01),
                         a = c(0.95, 0.8),
                         gamma = c(0.2, 0.8),
                         lambda = 1,
                         T = c(10))


data <- ddply(variables, .(qoe.infinite = qoe.infinite(B, a, lambda, alpha, beta, gamma),
                           qoe.finite = qoe.finite(B, a, lambda, T, alpha, beta, gamma)))

data$a <- factor(data$a)
data$gamma <- factor(data$gamma)
data$T <- factor(data$T)

molten.data <- melt(data, measure.vars = c('qoe.infinite', 'qoe.finite'))
molten.data$variable <- factor(molten.data$variable, 
                               levels = c('qoe.finite', 'qoe.infinite'),
                               labels  = c(label.finite, label.infinite))

p <- ggplot(molten.data, aes(x = B, y = value, color = gamma, linetype = variable)) +
  geom_line() +
  facet_grid(. ~ a) +
  scale_colour_manual(values = color.palette, name = label.prebuffering.sensitivity) +
  scale_x_log10(name = label.normalized.video.buffer) +
  scale_y_continuous(name = label.qoe) +
  scale_linetype_discrete(name = label.type) +
  guides(colour = guide_legend(order = 1),
         linetype = guide_legend(order = 2))

save.full.row.plot(p)
