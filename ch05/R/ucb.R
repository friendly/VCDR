UCB <- aperm(UCBAdmissions, c(3,1,2))

# mutual independence
mosaic(UCB, shade=TRUE, split_vertical=c(FALSE, TRUE, TRUE))

# two-way views
mosaic(~ Dept + Gender, data=UCB, shade=TRUE)
mosaic(~ Dept + Admit, data=UCB, shade=TRUE)

#mosaic(UCB, expected=~Dept*Gender + Admit)
mosaic(UCB, expected=~Dept*Gender + Admit, split_vertical=c(FALSE, TRUE, TRUE))

mosaic(UCB, expected=~Dept*Gender + Admit*Gender, split_vertical=c(FALSE, TRUE, TRUE))



library(MASS)
mod1 <- loglm(~ Gender + Admit, data=UCB)
mod2 <- loglm(~ Gender*Dept + Admit, data=UCB)

mod3 <- loglm(~ Gender*Dept + Admit*Dept, data=UCB)

# same as mod3
mod3a <- loglm(~ (Gender + Admit)*Dept, data=UCB)

anova(mod1, mod2, mod3)



