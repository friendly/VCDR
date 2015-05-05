library(vcdExtra)
data("ICU", package="vcdExtra")

# remove redundant variables (race, coma)
ICU <- ICU[,-c(4, 20)]

icu.glm2 <- glm(died ~ age + cancer  + admit + uncons, data=ICU, family=binomial)


library(car)


# marginal plots

op <- par(mfrow=c(2,2), mar=c(4,4,1,2.5)+.1, cex.lab=1.4)
plot(died ~ age, data=ICU, col=c("lightblue", "pink"))
plot(died ~ cancer, data=ICU, col=c("lightblue", "pink"))
plot(died ~ admit, data=ICU, col=c("lightblue", "pink"))
plot(died ~ uncons, data=ICU, col=c("lightblue", "pink"))
par(op)

op <- par(mfrow=c(2,2), mar=c(4,4,1,2)+.1, cex.lab=1.25)
plot(as.numeric(died)-1 ~ age, data=ICU, ylab="died")
abline(lm(as.numeric(died)-1 ~ age, data=ICU))
lines(ICU$age, predict(glm(died ~ age, data=ICU, family=binomial), type="response"))
plot(as.numeric(died)-1 ~ cancer, data=ICU, ylab="died")
plot(as.numeric(died)-1 ~ admit, data=ICU, ylab="died")
plot(as.numeric(died)-1 ~ uncons, data=ICU, ylab="died")
par(op)

library(gpairs)
gpairs(ICU[,c("died", "age", "cancer", "admit", "uncons")], 
  diag.pars=list(fontsize=16, hist.color="lightgray"),
  mosaic.pars=list(gp=shading_Friendly, gp_args=list(interpolate=1:4)))


pch <- ifelse(ICU$died=="No", 1, 2)
avPlots(icu.glm2, id.n=2, pch=pch, cex.lab=1.3)

crPlots(icu.glm2, id.n=2)
crPlot(icu.glm2, "age", id.n=2)

# avPlot for an additional variable

icu.glm2a <- glm(died ~ age + cancer  + admit + uncons + systolic, data=ICU, family=binomial)

anova(icu.glm2, icu.glm2a, test="Chisq")

avPlot(icu.glm2a, "systolic", id.n=3, pch=pch)


# delete case 84
icu.glm2b <- update(icu.glm2a, subset=!(rownames(ICU)==84))
compareCoefs(icu.glm2a, icu.glm2b, se=FALSE)




