data <- read.csv('sorted_results.csv', sep = " ", col.names = c('n', 'theta.1', 'theta.2', 'waiting.mean', 'energy.mean'))
data <- melt(data, id = c("waiting.mean"))
data <- subset(data, variable != "energy.mean")

p <- ggplot(data, aes(x = waiting.mean,
                      y = value,
                      color = variable)
                  ) +
   geom_point(size = 1) +
   scale_x_continuous(label.waiting.time, limits = c(1e-1, 20)) +
   scale_y_continuous(label.number.servers, limits = c(0, 60)) +
   scale_colour_manual(label.parameter,labels = c(expression(n), expression(theta[1]), expression(theta[2])), values = color.palette)

save.full.row.plot(p)