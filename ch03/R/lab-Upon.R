# Mosteller-Wallace, 1963: Table 2.4
# Frequencies of 'upon' in works by Hamilton

count <- 0:5
Freq <- c(129, 83, 20, 9, 5, 1)
sum(Freq)

Upon <- data.frame(count, Freq)  

library(xtable)
xtable(t(Upon))

## this is awkward, because goodfit() requires a data frame or matrix
## to have the frequency column first, rather than recognizing column
## labels

upon <- Upon[,2:1]
(up0 <- goodfit(upon, type="poisson"))
(up1 <- goodfit(upon, type="nbinomial"))

summary(up0)
summary(up1)

plot(up0)
plot(up1)



