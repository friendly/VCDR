data("CodParasites", package = "countreg")
str(CodParasites)

## omit NAs in response
CodParasites <- subset(CodParasites, !is.na(intensity))

# make a numeric variable from area
CodParasites$areaEW <- as.numeric(CodParasites$area)

library(MASS)
library(countreg)
library(car)
library(effects)

cp_p      <-    glm(intensity ~ length + area * year, data = CodParasites, family = poisson)
cp_p_lin  <-    glm(intensity ~ length + areaEW * year, data = CodParasites, family = poisson)
Anova(cp_p_lin)
anova(cp_p_lin, cp_p, test="Chisq")

plot(Effect(c("area", "year"), cp_p), layout=c(3,1))
plot(Effect(c("areaEW", "year"), cp_p_lin), layout=c(3,1))


cp_nb     <- glm.nb(intensity ~ length + area * year, data = CodParasites)
cp_nb_lin <- glm.nb(intensity ~ length + areaEW * year, data = CodParasites)
Anova(cp_nb_lin)
anova(cp_nb_lin, cp_nb, test="Chisq")

plot(Effect(c("area", "year"), cp_nb), layout=c(3,1))
plot(Effect(c("areaEW", "year"), cp_nb_lin), layout=c(3,1))
