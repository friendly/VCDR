
library(vcdExtra)

haireye <- margin.table(HairEyeColor, 1:2)

haireye.df <- expand.dft(as.data.frame(haireye))

haireye.mca <- mjca(haireye.df)
summary(haireye.mca)

# plot, but don't use point labels
res <- plot(haireye.mca, labels=0)

coords <- res$cols
# simplify point labels, for display purposes
rownames(coords) <- gsub("Hair|Eye", "", rownames(coords))
text(coords, rownames(coords), col=rep(c("blue", "red"), each=4), pos=3)

coords[1:4,] <- coords[order(coords[1:4,1]),] 
coords[5:8,] <- coords[4+order(coords[5:8,1]),]
lines(coords[1:4,], lty=1, col="blue")
lines(coords[5:8,], lty=4, col="red")

# 3-way table
HEC.df <- expand.dft(as.data.frame(HairEyeColor))
HEC.mca <- mjca(HEC.df)
summary(HEC.mca)

res <- plot(HEC.mca)



