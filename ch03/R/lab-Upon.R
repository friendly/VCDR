# Mosteller-Wallace, 1963: Table 2.4
# Frequencies of 'upon' in works by Hamilton

count <- 0:5
Freq <- c(129, 83, 20, 9, 5, 1)
sum(Freq)

# as a data.frame
Upon <- data.frame(Freq, count)  

# one way table
Upon.tab <- xtabs(Freq ~ count, data=Upon)

(up0 <- goodfit(Upon, type="poisson"))
(up1 <- goodfit(Upon, type="nbinomial"))

summary(up0)
summary(up1)

plot(up0)
plot(up1)



