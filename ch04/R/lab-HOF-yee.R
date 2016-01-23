#The positive-Poisson distribution is mentioned in Tables 17.1
#and 17.6 of my book.
#There are dpqr-type functions to go with it.
#It operates almost identical with vglm() as poisson()
#does with glm().
#However, for this data set, it seems a positive-Poisson
#distribution does not fit well.
#A zeta distribution fares much better, although it's not
#perfect either; its support is on the positive integers.
#
#cheers
#
#Thomas


library(vcd)
years <- 1:15
inducted <- c(46, 10,  8,  7,  8,  4,  2,  4,  6,  3,  3, 1,  4,  1,  2)
HOF.df <- data.frame(years, inducted)
HOF.tab <- xtabs(inducted ~ years, data=HOF.df)
goodfit(HOF.tab)
summary(HOF.tab)
plot(goodfit(HOF.tab), xlab='Number of years to HOF election')


library("VGAM")


hof.tpois0 <-
  vglm(years ~ 1, pospoisson, data=HOF.df, weights=inducted)
hof.tpois0
coef(hof.tpois0, matrix = TRUE)

N <- with(HOF.df, sum(inducted))
lambda.hat <- Coef(hof.tpois0)

# Fitted versus observed
fitted <- N * dpospois(depvar(hof.tpois0), lambda = lambda.hat)
cbind(N * dpospois(depvar(hof.tpois0), lambda = lambda.hat),
      weights(hof.tpois0, type = "prior"))
rootogram(inducted, fitted)



# Check by converting it to ungrouped data
HOF <- rep(HOF.df$years, times = HOF.df$inducted)
hof.tpois5 <-
  vglm(HOF ~ 1, pospoisson)
hof.tpois5
coef(hof.tpois5, matrix = TRUE)
Coef(hof.tpois5)




hof.zeta <-
  vglm(years ~ 1, zetaff, data=HOF.df, weights=inducted)
hof.zeta
coef(hof.zeta, matrix = TRUE)

p.hat <- Coef(hof.zeta)
fitted <- N * dzeta(depvar(hof.zeta), p = p.hat)
# Fitted versus observed
cbind(N * dzeta(depvar(hof.zeta), p = p.hat),
      weights(hof.zeta, type = "prior"))

rootogram(inducted, fitted)



#ps. hof.tpois1 isn't right  in a sense.
#(And it does depend on what question being answered).
#There is no reason why hof.tpois1 shouldn't be
#an ordinary Poisson regression because the numbers
#inducted could possibly be 0 (except at year=0).
#The problem is that the data point (year=0, inducted=0)
#is not enforced by hof.tpois1. And one
#would ideally want to model things as a function of year.



# This is rather unsatisfactory:


hofdf <- data.frame(rbind(cbind(years=0, inducted=0), HOF.df))

hofdf <- transform(hofdf, wt = 1)
hofdf$wt[1] <- 1e1  # Weight it more heavily

hofdf


hof.pois1 <-
  vgam(inducted ~ s(years, df = 6), poissonff,
       data=hofdf, weight = wt)
plot(hof.pois1, se = TRUE, lcol = "blue", scol = "orange")

lambda.hat <- c(exp(predict(hof.pois1)))


# Fitted versus observed
cbind(observed = depvar(hof.pois1),
      lambda = lambda.hat)

