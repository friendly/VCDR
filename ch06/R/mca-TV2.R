
library(vcdExtra)
data("TV", package="vcdExtra")

# reduce number of levels of Time
TV.df <- as.data.frame.table(TV)
levels(TV.df$Time) <- rep(c("8:00-8:59", "9:00-9:59", "10:00-10:44"), c(4, 4, 3))

# re-label for  display
levels(TV.df$Time) <- c("8", "9", "10")
TV3 <- xtabs(Freq ~ Day + Time + Network, TV.df)
structable(Day ~ Network + Time, TV3)

# stacking
TV3S <- as.matrix(structable(Day ~ Network + Time, TV3), sep=":")
ca(TV3S)
plot(TV3S)


TV.mca <- mjca(TV3)
summary(TV.mca)


res <- plot(TV.mca, labels=0, pch='.', cex.lab=1.2)
coords <- data.frame(res$cols)
faclevs <- strsplit(rownames(coords), ":")
coords$factor <- sapply(faclevs, function(x) x[1])
coords$levels <- sapply(faclevs, function(x) x[2])
coords

cols <- c("red", "green3", "blue")
nlev <- table(coords$factor)
segments(0, 0, coords[9:11,1], coords[9:11,2], adjustcolor(col=cols[3], alpha=0.3), lwd=2)

points(coords[,1:2], pch=rep(15:17, nlev), col=rep(cols, nlev), cex=1.25)
text(coords[,1:2], coords$levels, col=rep(cols,nlev), cex=1.2, pos=3, xpd=TRUE)

legend("topright",
	legend=unique(coords$factor),
	title = "Factor", title.col="black", 
	col=cols, text.col=cols, pch=15:17,
	bg="gray90", cex=1.2)
	








