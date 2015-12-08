citekeys = read.csv('citekeys.csv', sep=';', comment.char = '#')
references = read.csv('references.csv', sep=';', comment.char = '#')

combined <- sort(union(levels(citekeys$key), levels(references$key)))

data <- left_join(mutate(citekeys, key=factor(key, levels=combined)),
                         mutate(references, key=factor(key, levels=combined)),
                         by = 'key')

data$citation <- as.character(sprintf("[%d]", data$reference))

data <- subset(data, !is.na(area) | !is.na(methodology))

p <- ggplot(data, aes(x = area,
                      y = methodology,
                      color = chapter,
                      group = reference)) +
  geom_text(aes(label=citation), position=position_dodge(0.4, 0.4)) +
  scale_x_continuous('Area',
                     breaks = c(0.5, 1.5, 2.5),
                     labels = c('Cloud', 'Network', 'Application')) +
  scale_y_continuous('Area',
                     breaks = c(0.5, 1.5, 2.5),
                     labels = c('Simulation', 'Measurement', 'Theoretical')) +
  expand_limits(x = c(0, 3), y = c(0, 3))

print(p)