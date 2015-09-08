library(vcdExtra)
data("TV", package="vcdExtra")

library(ca)

TV2 <- margin.table(TV, c(1,3))
TV2
# this should be an example in ch05, \S 5.3, or done side-by-side with the 2D ca solution

# try generating CMYK colors directly
grDevices::pdf.options(colormodel = "cmyk")
setwd("C:/Dropbox/Documents/VCDR/ch06/fig")

pdf(file="TV2-ca-CMYK.pdf", h=6, w=6)
op <- par(cex=1.3, mar=c(5,4,1,1)+.1)
TV.ca <- ca(TV2)
res <- plot(TV.ca)
segments(0, 0, res$cols[,1], res$cols[,2], col="red", lwd=2)
par(op)
dev.off()

summary(TV.ca)

#pdf(file="TV2-mosaic0.pdf", h=6, w=6)
#mosaic(TV2, shade=TRUE, legend=FALSE, labeling=labeling_residuals, suppress=0)
#dev.off()

# better: sort by CA dim 1
days.order <- order(res$rows[,1]) 
# same as
days.order <- order(TV.ca$rowcoord[,1])
mosaic(TV2[days.order,], shade=TRUE, legend=FALSE, labeling=labeling_residuals, suppress=0)

# transpose to conform to the CA plot
pdf(file="TV2-mosaic-CMYK.pdf", h=6, w=6)
days.order <- order(TV.ca$rowcoord[,1])
mosaic(t(TV2[days.order,]), shade=TRUE, legend=FALSE, labeling=labeling_residuals, suppress=0)
dev.off()
 

