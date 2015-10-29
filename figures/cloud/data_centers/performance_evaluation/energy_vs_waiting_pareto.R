data <- read.csv('energy_vs_waiting_pareto.csv', sep = ",", col.names = c('mean.waiting', 'mean.energy', 'is.pareto'))
data$is.pareto  <- factor(data$is.pareto, labels = c("No", "Yes"))

sample.count <- 20000
pareto.rows <- subset(data, is.pareto == 'Yes')
non.pareto.rows <- subset(data, is.pareto == 'No')
sampled.non.pareto.rows <- non.pareto.rows[sample(nrow(non.pareto.rows), sample.count),]

sampled.data <- rbind(pareto.rows, sampled.non.pareto.rows)

p <- ggplot(sampled.data, aes(x = mean.waiting.ms, 
                      y = mean.energy, 
                      color = is.pareto, 
                      order = as.numeric(is.pareto))) +
    geom_point(size = 1) +
    scale_x_continuous(name = label.waiting.time, limits = c(0, 20)) +
    scale_y_continuous(name = label.power, limits = c(50, 100)) +
    scale_colour_manual(name = label.pareto, values = color.palette)

save.full.row.plot(p)