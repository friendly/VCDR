data("Donner", package="vcdExtra")

donner.mod <- glm(survived ~ age, data=Donner, family=binomial)
summary(donner.mod)

library(ggplot2)
ggplot(Donner, aes(age, survived)) + theme_bw() +
	geom_point(position = position_jitter(height = 0.02, width = 0)) +
	stat_smooth(method = "glm", family = binomial, formula = y ~ x,
	fill="blue", alpha = 0.2, size=2) 

ggplot(Donner, aes(age, survived)) + theme_bw() +
	geom_point(position = position_jitter(height = 0.02, width = 0)) +
	stat_smooth(method = "loess", span=0.9, color="red", fill="red", alpha = 0.2, size=2, na.rm=TRUE) +
	ylim(0,1)

library(splines)
ggplot(Donner, aes(age, survived)) + theme_bw() +
	geom_point(position = position_jitter(height = 0.02, width = 0)) +
	stat_smooth(method = "glm", family = binomial, formula = y ~ ns(x, 2),
	color="darkgreen", fill="darkgreen", alpha = 0.3, size=2) 

###########################################

ggplot(Donner, aes(age, survived, color = sex)) + theme_bw() +
	geom_point(position = position_jitter(height = 0.02, width = 0)) +
	stat_smooth(method = "glm", family = binomial, formula = y ~ x,
	alpha = 0.2, size=2, aes(fill = sex))
