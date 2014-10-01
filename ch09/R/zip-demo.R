# demonstrate zero-inflated Poisson

library(VGAM)
set.seed(1234)
data1 <- rzipois(200, 3, 0)
tdata1 <- table(data1)
barplot(tdata1, xlab="Count", ylab="Frequency", main="Poisson(3)")
#abline(v=1+mean(data1), col="red", lwd=3)

data2 <- rzipois(200, 3, .3)
tdata2 <- table(data2)
barplot(tdata2, xlab="Count", ylab="Frequency", main=expression("ZI Poisson(3, " * pi * "= .3)"))
#abline(v=1+mean(data2), col="red", lwd=3)

# generalize this?

sim.parm <- expand.grid(mu=c(3, 6), pi=c(0, .3, .6))
sim.parm


# using density functions
lambda <-3
x <- 0:10
pi <- 0.2

barplot(rbind(dzipois(x, lambda, pi), dpois(x, lambda)),
        beside = TRUE, col = c("blue", "green"),
        main = paste(" Poisson(", lambda, ") (green) vs. ",
                     "ZI Poisson(", lambda, ", pi = ", pi, ") (blue)",
                     sep = ""),
        names.arg = as.character(x),
        xlab = "Count", ylab="Density"
        )
