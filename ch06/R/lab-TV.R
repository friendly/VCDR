#' ---
#' title: "TV data, Exercise 6.9"
#' author: "Michael Friendly"
#' date: "04 Feb 2016"
#' ---

data("TV", package="vcdExtra")
library(vcdExtra)
library(ca)

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

#custom plot

res <- plot(TV3.mca, labels=0, pch='.', cex.lab=1.2)
coords <- data.frame(res$cols, TV3.mca$factors)      
#nlev <- rle(as.character(coords$factor))$lengths
nlev <- TV3.mca$levels.n
fact <- unique(as.character(coords$factor))

cols <- c("blue", "red", "brown")
lwd <- 2
plot(Dim2 ~ Dim1, type='n', data=coords)
points(coords[,1:2], pch=rep(16:18, nlev), col=rep(cols, nlev), cex=1.2)
text(coords[,1:2], labels=coords$level, col=rep(cols, nlev), pos=3, cex=1.2, xpd=TRUE)

multilines(coords[, c("Dim1", "Dim2")], group=coords$factor, col=cols, lwd=lwd)

