library(vcdExtra)
data("CoalMiners", package="vcd")


# simplify variable names for glm analysis & displays 
CM <- as.data.frame(CoalMiners)
colnames(CM)[1:2] <- c("B", "W")
str(CM)


cm.glm0 <- glm(Freq ~ B + W + Age, data=CM, family=poisson)
cm.glm1 <- glm(Freq ~ B * W + Age, data=CM, family=poisson)

vcdExtra::summarise(glmlist(cm.glm0, cm.glm1))

vnames <- list(set_varnames = c(B="Breathlessness", W="Wheeze"))
lnames <- list(B=c("B", "b"), W = c("W", "w"))
mosaic(cm.glm1, ~ Age + B + W, labeling_args=vnames, set_labels=lnames)

cm.glm2 <- glm(Freq ~ B * W + (B + W) * Age, data=CM, family=poisson)
cm.glm2

vcdExtra::summarise(glmlist(cm.glm1, cm.glm2))

Anova(cm.glm2)
# same as:
#cm.glm2 <- glm(Freq ~ (B + W + Age)^2, data=CM, family=poisson)
#cm.glm2

# show standardized residuals, using Friendly shading
mosaic(cm.glm2, ~ Age + B + W, labeling_args=vnames, set_labels=lnames, 
  residuals_type="rstandard", gp=shading_Friendly)


# numeric version of Age
#CM$age <- c(22, 27, 32, 37, 42, 47, 52, 57, 62)
CM$age <- rep(seq(22, 62, 5), each=4)
#CM


# model a linear change in OR with age
CM$ageOR <- (CM$B=="B") * (CM$W=="W") * CM$age
cm.glm3 <- update(cm.glm2, . ~ . + ageOR)

vcdExtra::summarise(glmlist(cm.glm0, cm.glm1, cm.glm2, cm.glm3))

# generate a latex table; requires hand editing

sumry <- vcdExtra::summarise(glmlist(cm.glm0, cm.glm1, cm.glm2, cm.glm3))
terms <- c("LLM{B, W, A}", "LLM{BW, A}", "LLM{BW,BA,WA}", "LLM{BWx,BA,WA}")

sumry <- cbind(terms, sumry)
sumry
library(xtable)
xtable(sumry, digits=c(0,0,2,0,4,2,2))


#######################################

cm.glm2a <- glm(Freq ~ B * W + (B + W) * age, data=CM, family=poisson)
#anova(cm.glm2a)

cm.glm2b <- glm(Freq ~ B * W + (B + W) * poly(age,2), data=CM, family=poisson)


anova(cm.glm0, cm.glm1, cm.glm2)

anova(cm.glm2, cm.glm2a, cm.glm2b)

vcdExtra::summarise(glmlist(cm.glm0, cm.glm1, cm.glm2, cm.glm2a, cm.glm2b))

#cm.glm4 <- glm(Freq ~ B * W * age + (B + W) * age, data=CM, family=poisson)








