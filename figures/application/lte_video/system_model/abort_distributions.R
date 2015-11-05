data <- read.csv('abort_distributions.csv')

p <- ggplot(data, aes(x = time,
                      y = value,
                      color = variable)) +
  geom_line() +
  labs(x = label.abort.time,
       y = label.pdf.abort.time,
       color = label.user.model) +
  scale_y_continuous(breaks = seq(0, 1e-3, length.out=5), labels = notation.si) +
  scale_x_continuous(breaks = seq(0, 1600, 400)) +
  scale_colour_manual(values = color.palette)

save.full.row.plot(p)
