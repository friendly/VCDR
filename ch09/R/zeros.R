# from http://r.789695.n4.nabble.com/R-Fixed-zeros-in-tables-td813435.html
## Fienberg, The Analysis of Cross-Classified Contingency Tables, 2nd ed., p.148.
## Results from survey of teenagers regarding their health concerns,
## from Brunswick 1971.

Health <- expand.grid(concerns = c("sex", "menstrual", "healthy", "nothing"),
                      age      = c("12-15", "16-17"),
                      gender   = c("M", "F"))
Health$Freq <- c(4, 0, 42, 57, 2, 0, 7, 20,
                 9, 4, 19, 71, 7, 8, 10, 21)

# make a Latex table
health.table <- ftable(gender+age ~ concerns, health.tab)
library(xtable)
#xtable(health.table)
require(metrumrg)
print(xtable(ftable2data.frame(health.table)))

#require(Hmisc)
#latex(ftable2data.frame(health.table))
#print(xtable(format(health.table)))

####################################################

# using glm()

health.glm0 <-glm(Freq ~  concerns + age + gender, data=Health, subset=(Freq>0),
      family=poisson)

#summary(health.glm1)

#mosaic(health.glm0, ~concerns+age+gender, residuals_type="rstandard")

health.glm1 <-glm(Freq ~  concerns + age * gender, data=Health, subset=(Freq>0),
      family=poisson)

vcdExtra::summarise(glmlist(health.glm0, health.glm1))

mosaic(health.glm1, ~concerns+age+gender, residuals_type="rstandard")

# other models
health.glm2 <-glm(Freq ~  concerns*gender + concerns*age, data=Health, subset=(Freq>0),
      family=poisson)
summary(health.glm2)

vcdExtra::summarise(glmlist(health.glm0, health.glm1, health.glm2))

# using loglm

health.tab <- xtabs(Freq ~ concerns + age + gender, data = Health)
structable(gender+age ~ concerns, health.tab)

#######################################################

library(MASS)

nonzeros <- ifelse(health.tab>0, 1, 0)
health.loglm0 <- loglm(~ concerns + age + gender,
              data = health.tab, start = nonzeros)
health.loglm0 
#structable(gender+age ~ concerns, round(fitted(health.loglm), 1))

health.loglm1 <- loglm(~ concerns + age * gender,
              data = health.tab, start = nonzeros)


# df is wrong
health.loglm2 <- loglm(~ concerns*gender + concerns*age,
              data = health.tab, start = nonzeros)
health.loglm2

vcdExtra::summarise(loglmlist(health.loglm0, health.loglm1, health.loglm2))



