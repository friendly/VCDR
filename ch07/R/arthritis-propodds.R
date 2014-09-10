library(vcd)
library(car)         # for Anova()
library(MASS)
data("Arthritis", package="vcd")

arth.polr <- polr(Improved ~ Sex + Treatment + Age, data=Arthritis, Hess=TRUE)
summary(arth.polr)
Anova(arth.polr)      # Type II tests


# p-values
(ctable <- coef(summary(arth.polr)))
# normal approximation
p <- 2* pnorm(abs(ctable[, "t value"]), lower.tail = FALSE)

df <- arth.polr$df.residual
p <- 2 * pt(abs(ctable[, "t value"]), df, lower.tail = FALSE)
(ctable <- cbind(ctable, `Pr(>|t|)` = p))


#newdat <- cbind(newdat, predict(m, newdat, type = "probs"))

### Plotting response probabilities

arth.fitp <- cbind(Arthritis,
                  arth.polr$fitted.values)
head(arth.fitp)

arth.fitp <- cbind(Arthritis,
                  predict(arth.polr, type="probs"))
head(arth.fitp)
                
                  
library(reshape2)
plotdat <- melt(arth.fitp, 
                id.vars = c("Sex", "Treatment", "Age", "Improved"), 
                measure.vars=c("None", "Some", "Marked"), 
                variable.name = "Level",
                value.name = "Probability")
## view first few rows
head(plotdat)



ggplot(plotdat, aes(x = Age, y = Probability, colour = Level)) + 
    geom_line(size=1.5) + theme_bw() + geom_point(color="black") +
    facet_grid(Sex ~ Treatment,  scales = "free", 
               labeller = function(x, y) sprintf("%s = %s", x, y)
               )

plotdat2 <- subset(plotdat,
                   as.character(Improved) == as.character(Level))

ggplot(plotdat, aes(x = Age, y = Probability, color = Level)) +
    geom_line(size=2.5) + theme_bw() + xlim(10,80) +
    geom_point(data = plotdat2, color="black", size=1.5) +
    facet_grid(Sex ~ Treatment,
               labeller = function(x, y) sprintf("%s = %s", x, y)
               )

library(ggplot2)
library(directlabels)
gg <- ggplot(plotdat, aes(x = Age, y = Probability, color = Level)) + 
    geom_line(size=2.5) + theme_bw() + xlim(10,80) +
    geom_point(color="black", size=1.5) +
    facet_grid(Sex ~ Treatment, # scales = "free", 
               labeller = function(x, y) sprintf("%s = %s", x, y)
               )
direct.label(gg)


plotdat2 <- subset(plotdat,
                     as.character(Improved) == as.character(Level))
ggplot(plotdat2, aes(x = Age, y = Probability, color = Level)) +
    geom_line(size=2.5) + theme_bw() + xlim(10,80) +
    geom_point(color="black", size=1.5) +
    facet_grid(Sex ~ Treatment,
               labeller = function(x, y) sprintf("%s = %s", x, y)
               )



# testing proportional odds assumption
# -- LR test -- compare the deviance of the PO model to the generalized logit model

library(VGAM)

arth.po <- vglm(Improved ~ Sex + Treatment + Age, data=Arthritis,
	family = cumulative(parallel=TRUE))
arth.po

arth.npo <- vglm(Improved ~ Sex + Treatment + Age, data=Arthritis,
	family = cumulative(parallel=FALSE))
arth.npo 

tab <- cbind(
	Deviance = c(deviance(arth.npo), deviance(arth.po)),
	df = c(df.residual(arth.npo), df.residual(arth.po))
	)
tab <- rbind(tab, diff(tab))
rownames(tab) <- c("GenLogit", "PropOdds", "LR test")
#tab
tab <- cbind(tab, pvalue=1-pchisq(tab[,1], tab[,2]))
tab

lrtest(arth.npo, arth.po)

## matrix form of coefs
coef(arth.po, matrix=TRUE)
coef(arth.npo, matrix=TRUE)

# partial PO

arth.ppo <- vglm(Improved ~ Sex + Treatment + Age, data=Arthritis,
	family = cumulative(parallel=FALSE ~ Sex))
#arth.ppo 
coef(arth.ppo, matrix=TRUE)

library(rms)
#ddist <- datadist(Sex,Treatment,Age)
#options(datadist='ddist')
arth.po2 <- lrm(Improved ~ Sex + Treatment + Age, data=Arthritis)
arth.po2
coef(arth.po2)
anova(arth.po2)


sfun <- function(y)
	c('Y>=1'=qlogis(mean(y >= 'None')),
	  'Y>=2'=qlogis(mean(y >= 'Some')),
	  'Y>=3'=qlogis(mean(y >= 'Marked')))

s <- summary(Improved ~ Sex + Treatment + Age, data=Arthritis, fun=sfun)
plot(s,which=1:3,pch=1:3,xlab='logit',main='',xlim=c(-2.5,2.5))

op <- par(mfrow=c(1,3))
plot.xmean.ordinaly(Improved ~ Sex + Treatment + Age, data=Arthritis,
     lwd=2, cex=1.5, pch=16, subn=FALSE)
par(op)



#############################################################
# effect plots


library(effects)
arth.effects <- allEffects(arth.polr, xlevels=list(age=seq(15,45,5)) )
plot(arth.effects)  # visualize all main effects

plot(arth.effects, rows=1, cols=3)
plot(arth.effects, rows=1, cols=3, style='stacked')

plot(Effect("Sex", arth.polr), style='stacked') # multiline has no effect

summary(Effect("Sex", arth.polr))

plot(Effect("Age", arth.polr))
plot(Effect("Age", arth.polr), style='stacked', key.args=list(x=.6, y=.9))



# plot higher-order terms not in model ...
plot(Effect(c("Sex", "Age"), arth.polr))
plot(Effect(c("Treatment", "Age"), arth.polr))

plot(Effect(c("Sex", "Age"), arth.polr), style="stacked", key.arg=list(x=.3, y=.9))

plot(Effect(c("Treatment", "Age"), arth.polr), style="stacked", key.arg=list(x=.8, y=.9))

plot(Effect(c("Treatment", "Sex", "Age"), arth.polr), style="stacked", key.arg=list(x=.8, y=.9))

# latent variable plot
plot(Effect(c("Treatment", "Age"), arth.polr, latent=TRUE), lwd=3)
plot(Effect(c("Treatment", "Sex", "Age"), arth.polr, latent=TRUE))

