data("TV", package="vcdExtra")

# reduce number of levels of Time
TV.df <- as.data.frame.table(TV)
levels(TV.df$Time) <- rep(c("8:00-8:59", "9:00-9:59", "10:00-10:44"), c(4, 4, 3))
TV2 <- xtabs(Freq ~ Day + Time + Network, TV.df)

mjca(TV2)
plot(mjca(TV2))
