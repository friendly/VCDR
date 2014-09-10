data("Donner", package="vcdExtra")
library(car)

# make survived a factor

Donner$survived <- factor(Donner$survived, labels=c("no", "yes"))

## get family size
#family.size <- table(Donner$family)[Donner$family]
##Donner$family.size <- ave(as.numeric(Donner$family), Donner$family, FUN=length)
#
## but Other should be recorded as singles
#
#family.size[Donner$family == "Other"]


# no, just go by last name

lname <- strsplit(rownames(Donner), ",")
lname <- sapply(lname, function(x) x[[1]])

Donner$family.size <- as.vector(table(lname)[lname])

library(car)
donner.mod4a <- glm(survived ~ poly(age,2) * sex + family.size, data=Donner, family=binomial)
Anova(donner.mod4a)

donner.mod4b <- glm(survived ~ poly(age,2) * sex + poly(family.size), data=Donner, family=binomial)
Anova(donner.mod4b)

library(effects)

donner.eff4a <- allEffects(donner.mod4a, xlevels=list(age=seq(0,50,5)))
plot(donner.eff4a, ticks=list(n=8))

donner.eff4b <- allEffects(donner.mod4b, xlevels=list(age=seq(0,50,5)))
plot(donner.eff4b, ticks=list(n=8))

