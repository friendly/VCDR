#' ---
#' title: " Exercise 5.2 - AirCrash data"
#' author: "Michael Friendly"
#' date: "27 Jan 2016"
#' ---

library(vcdExtra)
data("AirCrash", package = "vcdExtra")
aircrash.tab <- xtabs(~ Phase + Cause, data = AirCrash)

# default plot
mosaic(aircrash.tab, shade=TRUE)

# avoid label overlap
mosaic(aircrash.tab, shade=TRUE, rot_labels=c(20,90,0,70))
mosaic(aircrash.tab, shade=TRUE, alternate_labels=TRUE)


# reordering factor levels
# reorder Phase temporarally
roworder <- c(3, 4, 1, 2, 5)
mosaic(aircrash.tab[roworder,], shade=TRUE, rot_labels=c(20,90,0,70))

# marginal frequencies
roworder <- order(rowSums(aircrash.tab))
colorder <- order(colSums(aircrash.tab))
mosaic(aircrash.tab[roworder, colorder], shade=TRUE, rot_labels=c(20,90,0,70))

library(ca)
aircrash.ca <- ca(aircrash.tab)
aircrash.ca

# reorder by CA coordinates on Dim 1
roworder <- order(aircrash.ca$rowcoord[,"Dim1"])
colorder <- order(aircrash.ca$colcoord[,"Dim1"])
aircrash.tab[roworder, colorder]
mosaic(aircrash.tab[roworder, colorder], shade=TRUE, rot_labels=c(20,90,0,70))



