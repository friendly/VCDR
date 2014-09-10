data("Donner", package="vcdExtra")

# make survived a factor
Donner$survived <- factor(Donner$survived, labels=c("no", "yes"))

donner.mod1 <- glm(survived ~ age + sex, data=Donner, family=binomial)
donner.mod2 <- glm(survived ~ age * sex, data=Donner, family=binomial)

donner.mod3 <- glm(survived ~ poly(age,2) + sex, data=Donner, family=binomial)


library(car)

crPlots(donner.mod1, id.n=2)
crPlots(donner.mod3, id.n=2)

# just do age
crPlots(donner.mod1, ~age, id.n=2)

#crPlots(donner.mod1, ~age, id.n=3,
#  id.method=abs(residuals(donner.mod1, type="pearson")))

crPlots(donner.mod3, ~poly(age,2), id.n=2)
# crPlots(donner.mod3, ~.-sex, id.n=2)  # same

crPlot(donner.mod3, ~sex, id=2)


##########################


col <- ifelse(Donner$survived=="yes", "blue", "red")
pch <- ifelse(Donner$sex=="Male", 16, 17)
avPlots(donner.mod1, id.n=2, col=col, pch=pch, col.lines="darkgreen")


avPlot(donner.mod1, "age", id.n=2, pch=pch, col=col, col.lines="darkgreen", cex.lab=1.2)
text(30, -0.4, expression(beta[age]*" = -0.034"), pos=4, cex=1.25, col="darkgreen")

avPlot(donner.mod1, "sexMale", id.n=2, pch=pch, col=col, col.lines="darkgreen", cex.lab=1.2)
text(0, 0.1, expression(beta[sexMale]*" = -1.21"), pos=4, cex=1.25, col="darkgreen")

# constructed variable plot

Donner$xlogx <- with(Donner, coef(donner.mod1)["age"] * age * log(age))

donner.cvmod <- update(donner.mod1, . ~ . + xlogx)

lambda <- 1 + coef(donner.cvmod)[4]

crPlot(donner.cvmod, "xlogx", id.n=2, xlab="age * log(age)")
avPlot(donner.cvmod, "xlogx", id.n=2)

# doesn't work for binary responses
#boxTidwell(survived ~ age, other.x=sex, data=Donner)


#ceresPlots(donner.mod1, id.n=2)


avPlots(donner.mod2, id.n=2)

