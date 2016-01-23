# Exercise 6.9

data("TV", package="vcdExtra")
# reduce number of levels of Time
TV.df <- as.data.frame.table(TV)
levels(TV.df$Time) <- rep(c("8", "9", "10"), c(4, 4, 3))
TV3 <- xtabs(Freq ~ Day + Time + Network, TV.df)
structable(Day ~ Network + Time, TV3)

TV3S <- as.matrix(structable(Day ~ Network + Time, TV3), sep=":")

TV3S.ca <-ca(TV3S)
TV3S
plot(TV3S.ca, lines=c(FALSE, TRUE))


TV3.mca <- mjca(TV3)
plot(TV3.mca)
