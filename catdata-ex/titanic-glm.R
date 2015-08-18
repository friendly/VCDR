# after: http://www.r-bloggers.com/binary-classification-a-comparison-of-titanic-proportions-between-logistic-regression-random-forests-and-conditional-trees/

#load("c:/sasuser/catdata/R/data/ptitanic.rda")
data(Titanicp, package="vcdExtra")

# GLM
titanic.glm = glm(survived ~ pclass + sex + pclass:sex + age,
	family = binomial(logit), data = Titanicp)

titanic.glm = glm(survived ~ pclass*sex + age,
	family = binomial(logit), data = Titanicp)

summary(titanic.glm)

# effect plots
library(effects)
titanic.eff <- allEffects(titanic.glm)
# All high-order effects
plot(titanic.eff)
plot(titanic.eff[2], multiline=TRUE, key.args=list(x=.7, y=.9), ticks=list(n=7))

plot(effect('pclass', titanic.glm), main="Main effect of passenger class", ticks=list(n=7))


# re-fit model using pclass as an ordered factor -- but don't want to do this globally
Titanicp$pclass <- ordered(Titanicp$pclass)

	titanic.glm = glm(survived ~ pclass + sex + pclass:sex + age,
		family = binomial(logit), data = Titanicp, contrasts=list(pclass=contr.poly))
	summary(titanic.glm)	


# from effects package
titanic.glm1 <- glm(survived ~ pclass + sex + age, data=Titanicp, family=binomial)
titanic.glm2 <- glm(survived ~ (pclass + sex + age)^2, data=Titanicp, family=binomial)
titanic.glm3 <- glm(survived ~ (pclass + sex + age)^3, data=Titanicp, family=binomial)
anova(titanic.glm1, titanic.glm2, titanic.glm3, test="Chisq")

summary(titanic.glm2)
library(car)
Anova(titanic.glm2)

titanic.eff2 <- allEffects(titanic.glm2)


titanic.eff2a <- allEffects(titanic.glm2, 
	typical=median,
	given.values=c(pclass2nd=1/3, pclass3rd=1/3, sexmale=0.5)
	)
plot(titanic.eff2, ticks=list(at=c(.01, .05, seq(.1, .9, by=.2), .95, .99)), ask=FALSE)

#break them out
ticks <- list(at=c(.01, .05, seq(.1, .9, by=.2), .95, .99))
plot(titanic.eff2[1], ticks=ticks, layout=c(2,1))
plot(titanic.eff2[2], ticks=ticks, layout=c(3,1))
plot(titanic.eff2[3], ticks=ticks, layout=c(2,1))

# do as multiline plots
plot(titanic.eff2[1], ticks=ticks, multiline=TRUE, ci.style="bars", key=list(x=.7, y=.95))
plot(titanic.eff2[2], ticks=ticks, multiline=TRUE, ci.style="bars", key=list(x=.7, y=.95))
plot(titanic.eff2[3], ticks=ticks, multiline=TRUE, ci.style="bars", key=list(x=.7, y=.95))

plot(titanic.eff2[3], ticks=ticks, multiline=TRUE, ci.style="bars", key=list(x=.7, y=.95), lwd=2)

# 
# plot the 3-way effect
plot(effect("pclass*sex*age", titanic.glm2, xlevels=list(age=0:65)),
	ticks=list(at=c(.001, .005, .01, .05, seq(.1, .9, by=.2), .95, .99, .995)))

titanic.glm3 <- glm(survived ~ (pclass + sex + age)^3, data=Titanicp, family=binomial)
#summary(titanic.glm3)
Anova(titanic.glm3)

# 
library(vcdExtra)
LRstats(glmlist(titanic.glm1, titanic.glm2, titanic.glm3))

###################################################
# using plotmo -- requires removing missings

# remove missings on age
Titanicp <- Titanicp[!is.na(Titanicp$age),]

titanic.glm1 <- glm(survived ~ pclass + sex + age, data=Titanicp, family=binomial)
titanic.glm2 <- glm(survived ~ (pclass + sex + age)^2, data=Titanicp, family=binomial)
require(plotmo)

plotmo(titanic.glm1, se=2)
plotmo(titanic.glm2, se=2)



###################################################
## try using ggplot2

require(ggplot2)
# remove missings on age
Titanicp <- Titanicp[!is.na(Titanicp$age),]

ggplot(Titanicp, aes(age, as.numeric(survived)-1, color=sex)) +
	stat_smooth(method="glm", family=binomial, formula=y~x, alpha=0.2, size=2, aes(fill=sex)) +
	geom_point(position=position_jitter(height=0.03, width=0), size=1.5) 

# try other smoother methods

ggplot(Titanicp, aes(age, as.numeric(survived)-1, color=sex)) +
  stat_smooth(method="lm", formula=y~x, alpha=0.2, size=2, aes(fill=sex)) +
  geom_point(position=position_jitter(height=0.03, width=0)) +
  xlab("Age") + ylab("Pr (survived)")	



ggplot(Titanicp, aes(age, as.numeric(survived)-1, color=sex)) +
  stat_smooth(method="loess", formula=y~x, alpha=0.2, size=2, aes(fill=sex)) +
  geom_point(position=position_jitter(height=0.04, width=0)) +
  xlab("Age") + ylab("Pr (survived)")	


#Don't know how to automatically pick scale for object of type labelled. Defaulting to continuous
#Error in as.data.frame.default(x[[i]], optional = TRUE) : 
#  cannot coerce class ""labelled"" to a data.frame
#>
# with(Titanicp, 
# 	{
# 	age = as.numeric(age)
# 	ggplot(Titanicp, aes(age, survived, color=sex)) +
# 		stat_smooth(method="glm", family=binomial, formula=y~x, alpha=0.2, size=2, aes(fill=sex))
# 	})

#this works
p <- ggplot(Titanicp, aes(as.numeric(age), as.numeric(survived)-1, color=sex)) +
	stat_smooth(method="glm", family=binomial, formula=y~x, alpha=0.2, size=2, aes(fill=sex)) +
	geom_point(position=position_jitter(height=0.02, width=0)) +
	xlab("Age") + ylab("Pr (survived)")	

# facet by pclass
p + facet_grid(. ~ pclass) 

# add plot collapsed over pclass
p + facet_grid(. ~ pclass, margins=TRUE)

# facet by sex, curves by class
p <- ggplot(Titanicp, aes(as.numeric(age), as.numeric(survived)-1, color=pclass)) +
	stat_smooth(method="glm", family=binomial, formula=y~x, alpha=0.2, size=2, aes(fill=pclass)) +
	geom_point(position=position_jitter(height=0.02, width=0)) +
	xlab("Age") + ylab("Pr (survived)")	

# facet by pclass
p + facet_grid(. ~ sex) 
              

# plots on the logit scale, from Denis Murphy

mod <- glm(survived ~ age*sex, family=binomial, data=Titanicp)
modp <- cbind(Titanicp[, c("survived", "sex", "age")],
              predict(mod, se.fit = TRUE))
modp$obs <- c(-2.5, 2.5 )[modp$survived]

# Plot predicted logits with corresponding Wald CIs
p <- ggplot(modp, aes(x = age, y = fit, color = sex)) +
  geom_line(size = 2) +
  geom_ribbon(aes(ymin = fit - 1.96 * se.fit,
                  ymax = fit + 1.96 * se.fit,
                  fill = sex), alpha = 0.2,
              color = "transparent") +
  labs(x = "Age", y = "Estimated logit")
#p + geom_point(y=modp$obs, position=position_jitter(y=modp$obs, height=0.02, width=0))              
p + geom_point(aes(y=obs), position=position_jitter(height=0.25, width=0))
              
