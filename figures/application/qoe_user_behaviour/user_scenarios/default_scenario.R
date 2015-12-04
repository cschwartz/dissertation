source('_qoe_model.R')

variables <- expand.grid(alpha = c(0.05, 0.2, 0.8), 
                         beta = c(0.05, 0.15, 0.45),
                         gamma = 0.3,
                         B = seq(0.01, 10, by = 0.01),
                         a = 95 / 100,
                         lambda = 95)

data <- ddply(variables, .(qoe = qoe.infinite(B, a, lambda, alpha, beta, gamma)))

data$alpha <- factor(data$alpha)
data$beta <- factor(data$beta)

molten.data <- melt(data, measure.vars = c('qoe'))

max.molten.data <- molten.data %>% group_by(alpha, beta) %>% filter(max(value) == value)

p <- ggplot(molten.data, aes(x = B, y = value, color = alpha, linetype = beta)) + 
  geom_line() +
  geom_point(data = max.molten.data) +
  scale_color_manual(values = color.palette, name = label.alpha) +
  scale_x_continuous(name = label.normalized.video.buffer, breaks = seq(0, 7.5, by = 2.5)) +
  scale_y_continuous(name = label.qoe) +
  scale_linetype_discrete(name = label.beta) +
  guides(colour = guide_legend(order = 1),
         linetype = guide_legend(order = 2)) +
  coord_cartesian(x = c(0, 7.7))

save.full.row.plot(p)
