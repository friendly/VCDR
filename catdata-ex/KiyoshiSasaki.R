# data from Kiyoshi Sasaki, skiyoshi2001@yahoo.com
# posted to R-help 9-21-2013

dat <- structure(list(Presence = c(0L, 0L, 1L, 0L, 1L, 0L, 0L, 0L, 0L, 
0L, 0L, 0L, 1L, 1L, 0L, 1L, 0L, 0L, 1L, 0L, 0L, 1L, 1L, 1L, 1L, 
0L, 1L, 1L, 1L, 0L, 0L), Cover.size = c(7400, 2730, 2782, 1408, 
5400, 4170, 630, 1120, 720, 1080, 1197, 2160, 1638, 2850, 2420, 
90, 1017, 1260, 700, 1540, 100, 2720, 792, 360, 3048, 2620, 6253, 
6253, 740, 2520, 3520), Ivy = c(10L, 90L, 0L, 40L, 100L, 100L, 
100L, 90L, 50L, 95L, 95L, 95L, 0L, 85L, 10L, 5L, 5L, 80L, 70L, 
70L, 0L, 0L, 0L, 0L, 0L, 90L, 0L, 0L, 6L, 50L, 15L), Overstory = c(6L, 
4L, 4L, 4L, 3L, 6L, 5L, 4L, 5L, 8L, 8L, 8L, 8L, 8L, 6L, 6L, 9L, 
12L, 12L, 7L, 12L, 16L, 16L, 16L, 16L, 13L, 14L, 14L, 14L, 12L, 
12L), Moist = c(13.65, 15.3, 15.95, 17.2, 22.95, 18.25, 19.3, 
18.75, 17, 21.3, 17.7, 28, 20.85, 19.85, 24.75, 22.2, 26.6, 21.15, 
22, 15, 22.5, 30, 14.85, 27, 26.85, 19.55, 27.2, 27.2, 21.55, 
18, 19.9), Leaf = c(95L, 95L, 95L, 90L, 80L, 90L, 95L, 95L, 90L, 
80L, 80L, 80L, 95L, 90L, 95L, 95L, 95L, 100L, 100L, 95L, 5L, 
80L, 80L, 80L, 80L, 90L, 95L, 95L, 95L, 85L, 90L), Prey = c(0.047, 
0.051, 0.058, 0.057, 0.049, 0.046, 0.155, 0.108, 0.087, 0.093, 
0.133, 0.095, 0.081, 0.104, 0.11, 0.086, 0.124, 0.134, 0.12, 
0.139, 0.026, 0.045, 0.096, 0.035, 0.062, 0.065, 0.068, 0.068, 
0.087, 0.052, 0.082), Abundance = c(0.141542817, 0.092071611, 
0.077821012, 0.09906595, 0.113821138, 0.046202181, 0.641167367, 
1.131059246, 0.346020761, 0.647748304, 1.424230915, 2.098280764, 
0.23395382, 5.492325363, 1.713972302, 2.584891263, 1.049433858, 
0.81246522, 1.895848332, 2.8125, 0.089866484, 0.15392509, 0.561643836, 
0.400477763, 0.173869846, 1.158351129, 0.453206436, 0.50608052, 
0.347007064, 0.461928178, 0.264333242)), .Names = c("Presence", 
"Cover.size", "Ivy", "Overstory", "Moist", "Leaf", "Prey", "Abundance"
), row.names = 106:136, class = "data.frame")



xrange <- seq(from=min(dat$Overstory), to=max(dat$Overstory), length=100)


panelFunc <- function(x,y,data,...){
  plot(x,y,...)
  fit <- glm(y ~ x, data = dat, family = binomial(link = logit), na.action = na.exclude)
  lines(xrange, inv.logit(fit$coef[1]+ fit$coef[2]*xrange))
  }

coplot(dat$Presence ~ dat$Overstory | dat$Ivy, number=3, panel=panelFunc, rows=1)

library(ggplot2)
ggplot(dat, aes(Overstory, Presence), color=Ivy>50 ) +
  stat_smooth(method="glm", family=binomial, formula= y~x, alpha=0.3, aes(fill=Ivy>50))

dat$Ivy3 <- factor(cut(dat$Ivy,3))
ggplot(dat, aes(Overstory, Presence), color=Ivy3 ) +
  stat_smooth(method="glm", family=binomial, formula= y~x, alpha=0.3, aes(fill=Ivy3)) +
  geom_point(position=position_jitter(height=0.02, width=0.05))

ggplot(dat, aes(Overstory, Presence), color=Ivy3 ) +
  stat_smooth(method="glm", family=binomial, formula= y~x, alpha=0.3, aes(fill=Ivy3)) +
  geom_point(aes(color=Ivy3), position=position_jitter(height=0.02, width=0.05))
