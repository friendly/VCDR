data("Detergent", package="vcdExtra")

mosaic(Detergent, shade=TRUE)
mosaic(aperm(Detergent, c(3,1,2,4)), shade=TRUE)
doubledecker(Preference ~ Temperature + M_User + Water_softness, data=Detergent)

# mutual independence
require(MASS)
(det.mod0 <- loglm(~ Preference + Temperature + M_User + Water_softness, data=Detergent))
# examine addition of two-way terms
add1(det.mod0, ~ .^2, test="Chisq")

# model for Preference as a response
(det.mod1 <- loglm(~ Preference + (Temperature * M_User * Water_softness), data=Detergent))
mosaic(det.mod1)

# logit models for Preference
Detergent.df <- as.data.frame(Detergent)
det.logit1 <- glm(Preference=="Brand M" ~ Temperature + M_User + Water_softness, data=Detergent.df, weights=Detergent.df$Freq, family="binomial")

library(effects)
plot(allEffects(det.logit1))

add1(det.logit1, . ~ .^2)


# compare with correspondence analysis 
library(ca)
det.mca <- mjca(Detergent)
plot(det.mca)


