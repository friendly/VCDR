
## goodfit data examples:

## - binomial
data(Saxony)
Sax.fit <- goodfit(Saxony, type="binomial")
Sax.fit$par        # estimated parameters
Sax.fit            # print method
summary(Sax.fit)   # summary method
plot(Sax.fit)      # plot method: rootogram

data(WeldonDice)
dice.fit <- goodfit(WeldonDice, type="binomial", par=list(size=12))
dice.fit$par

dice.fit
summary(dice.fit)
plot(dice.fit)

#### bug in vcd:::print.goodfit -- doesn't pass digits= to print() via ...
print(dice.fit, digits=0)
#> print(dice.fit, digits=0)
#
#Observed and fitted values for binomial distribution
#with parameters estimated by `ML' 
#
# count observed       fitted
#     0      185 1.874228e+02
#     1     1149 1.146708e+03
#     2     3265 3.215618e+03
#     3     5475 5.465025e+03
#     4     6114 6.269367e+03
#     5     5194 5.114377e+03
#     6     3067 3.042206e+03
#     7     1331 1.329508e+03
#     8      403 4.236623e+02
#     9      105 9.600334e+01
#    10       18 1.468441e+01
#    11        0 1.361266e+00
#    12        0 5.783767e-02
#>

## - Poisson

data("HorseKicks")
HK.fit <- goodfit(HorseKicks, type="poisson")
HK.fit
summary(HK.fit)
plot(HK.fit)

## -- Poisson, negbin, geometric

data("Federalist", package="vcd")
Fed.fit0 <- goodfit(Federalist, type="poisson")
Fed.fit0$par
Fed.fit0
summary(Fed.fit0)

# -- rootograms 
plot(Fed.fit0, scale="raw", type="standing")
plot(Fed.fit0, type="standing")
plot(Fed.fit0, type="hanging")
plot(Fed.fit0, type="deviation")


Fed.fit1 <- goodfit(Federalist, type = "nbinomial")
summary(Fed.fit1)
plot(Fed.fit1, main="Negative binomial")


## try geometric and full negative binomial distribution
F.fit <- goodfit(Federalist, type = "nbinomial", par = list(size = 1))
F.fit2 <- goodfit(Federalist, type = "nbinomial")
summary(F.fit)
summary(F.fit2)
plot(F.fit)
plot(F.fit2)


data(Butterfly, package="vcd")
But.fit1 <- goodfit(Butterfly, type="poisson")
But.fit2 <- goodfit(Butterfly, type="nbinomial")
#summary(But.fit1)
#summary(But.fit2)
plot(But.fit1, main="Poisson")
plot(But.fit2, main="Negative binomial")

