
data("Cormorants", package="vcdExtra")

library(ggplot2)

# (a) Exploratory plots

set.seed(1234567)
my_theme <- theme_bw() + 
            theme(legend.position = c(0.8, 0.8),
                  legend.title = element_text(size=18),
                  legend.text = element_text(size=16))
	 
ggplot(Cormorants, aes(week, count, color=height)) + 
  geom_jitter() +
	stat_smooth(method="loess", size=2) + 
	scale_y_log10(breaks=c(1,2,5,10)) +
	geom_vline(xintercept=c(4.5, 9.5)) +
	my_theme

ggplot(Cormorants, aes(week, count, color=nest)) + 
  geom_jitter() +
  stat_smooth(method="loess", size=2) + 
  scale_y_log10(breaks=c(1,2,5,10)) +
  geom_vline(xintercept=c(4.5, 9.5)) +
  my_theme

ggplot(Cormorants, aes(week, count, color=station)) + 
	geom_jitter() +
  stat_smooth(method="loess", size=2) + 
  scale_y_log10(breaks=c(1,2,5,10)) +
  geom_vline(xintercept=c(4.5, 9.5)) +
  my_theme 

# faceting? -- no, data too thin
ggplot(Cormorants, aes(week, count, color=height)) + 
  geom_jitter() +
	stat_smooth(method="loess", size=2) + 
	scale_y_log10(breaks=c(1,2,5,10)) +
	geom_vline(xintercept=c(4.5, 9.5)) +
	facet_grid(~ nest) + my_theme

# try other smoother ?
ggplot(Cormorants, aes(week, count, color=height)) + 
  geom_jitter() +
	stat_smooth(method="lm", formula = y ~ splines::ns(x,4),  size=2) + 
	scale_y_log10(breaks=c(1,2,5,10)) +
	geom_vline(xintercept=c(4.5, 9.5)) +
	my_theme


#' ### (b)  models using week 
fit1 <-glm(count ~ week + station + nest + height + density + tree_health, data=Cormorants,
    family =  poisson)

library(car)
Anova(fit1)

# (c) plot fitted effects
library(effects)
plot(allEffects(fit1))

# (d)  --- better would be to use a spline function to allow for nonlinearity; also, drop tree_health
library(splines)
fit2 <-glm(count ~ ns(week,3) + station + nest + height + density , data=Cormorants,
    family = poisson)
Anova(fit2)
#plot(allEffects(fit2))
plot(Effect("week", fit2))

anova(fit1, fit2)

#' (e) ### test for overdispersion

require(AER, quietly=TRUE)
dispersiontest(fit1)
dispersiontest(fit2)

# or, 
fit2q <- update(fit2, family=quasipoisson)

library(MASS)
fit5 <- glm.nb(count ~ ns(week,3) + station + nest + height + density , data=Cormorants)

library(vcdExtra)
LRstats(fit1, fit2, fit3, fit4, fit5, sortby="AIC")
