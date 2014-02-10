data("Donner", package="vcdExtra")

donner.mod <- glm(survived ~ age, data=Donner, family=binomial)
summary(donner.mod)


ggplot(Donner, aes(age, survived)) +
geom_point(position = position_jitter(height = 0.02, width = 0)) +
stat_smooth(method = "glm", family = binomial, formula = y ~ x,
alpha = 0.2, size=2)


ggplot(Donner, aes(age, survived, color = sex)) +
geom_point(position = position_jitter(height = 0.02, width = 0)) +
stat_smooth(method = "glm", family = binomial, formula = y ~ x,
alpha = 0.2, size=2, aes(fill = sex))
