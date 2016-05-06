alpha<-c(0.2, 0.5)                    # note finer grid
beta<-c(0.05, 0.45)
L<-seq(1,3)
N<-seq(0,6)
xyz.func<-function(alpha,beta, L, N) { 1.5 + 3.5*exp(-(alpha *L + beta)*N)}
data <- expand.grid(alpha=alpha,beta=beta,L=L,N=N)
data$mos <- with(data,xyz.func(alpha,beta,L,N))      # need long format for ggplot

library(ggplot2)
# p <- ggplot(data,aes(x=alpha,y=mos,color=as.factor(beta))) +
#   geom_line() +
#   facet_grid(L ~ N)
# 
# print(p)

p <- ggplot(data,aes(x=N,y=mos,color=as.factor(L))) +
  geom_line() +
  facet_grid(alpha ~ beta) +
  scale_color_manual(values = color.palette) +
  labs(x = label.number.of.stalling.events, color = label.stalling.duration, y = label.qoe)
print(p)

save.full.row.plot(p)