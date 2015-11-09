data <- read.csv('tunnel_iat.csv')
data$origin <- factor(data$origin)

set.seed(23)

sampled.data <- data %>% sample_n(., 10000)

p <- ggplot(sampled.data, aes(x = IAT,
                      group = origin,
                      color= origin)) +
  geom_line(stat = 'ecdf') +
  facet_wrap(~ timeslot) +
  scale_x_log10(labels = notation.si) +
  scale_color_manual(values = color.palette) +
  labs(x = label.tunnel.iat,
       y = label.cdf.iat,
       color = label.distribution) +
  coord_cartesian(xlim = c(0.001, 0.4))

save.full.row.plot(p)
