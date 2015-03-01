cd("c:/sasuser/catdata")
Glass <- read.csv("glass.csv", stringsAsFactors=FALSE)

glass.tab <- xtabs(count ~ father + son, data=Glass)

dimnames(glass.tab) <- list(
  father=c("Manager", "Prof", "Skilled", "Supervis",  "Unskilled" ),
  son   =c("Manager", "Prof", "Skilled", "Supervis",  "Unskilled" ))

largs <- list(set_varnames=list(father="Father's Occupation", son="Son's Occupation"),
              abbreviate=10)
gargs <- list(interpolate=c(1,2,4,8))

# unordered

cd("C:/Documents and Settings/friendly/My Documents/My Dropbox/Documents/VCDR/ch01/fig")
pdf(file="glass-mosaic1.pdf", h=6, w=6)
mosaic(glass.tab, shade=TRUE, labeling_args=largs, gp_args=gargs,
  main="Alphabetic order", legend=FALSE, rot_labels = c(20, 90, 0, 90))
dev.off()


# reorder
ord <- c(2, 1, 4, 3, 5) 
pdf(file="glass-mosaic2.pdf", h=6, w=6)
mosaic(glass.tab[ord, ord], shade=TRUE, labeling_args=largs,  gp_args=gargs,
  main="Effect order", legend=FALSE, rot_labels = c(20, 90, 0, 90))
dev.off()

library(ca)

plot(ca(glass.tab))


