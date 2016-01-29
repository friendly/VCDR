# Test cacoord()
haireye <- margin.table(HairEyeColor, 1:2)
haireye.ca <- ca(haireye)
res <- plot(haireye.ca)
res

# shouldn't these be the same as returned by plot.ca()
coords <- cacoord(haireye.ca, type="symmetric")
coords

# constant scaling factor for each dimension
res$rows / coords$rows[, 1:2]
res$cols / coords$columns[, 1:2]


data("TV", package="vcdExtra")
library(vcdExtra)
library(ca)

# reduce number of levels of Time
TV.df <- as.data.frame.table(TV)
levels(TV.df$Time) <- rep(c("8", "9", "10"), c(4, 4, 3))
TV3 <- xtabs(Freq ~ Day + Time + Network, TV.df)

TV3.mca <- mjca(TV3)

cacoord(TV3.mca)

cacoord(TV3.mca,  rows=FALSE)

cacoord(TV3.mca, type="symmetric")
