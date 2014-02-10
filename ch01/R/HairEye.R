# Hair and Eye color example

library(vcd)
(HairEye <- margin.table(HairEyeColor, c(1, 2)))
assocstats(HairEye)

# reorder eye color
HairEye <- HairEye[,c(1,3,4,2)]
mosaic(HairEye, shade=TRUE)

# need to enlarge font size
library(ca)
op <- par(cex=1.4)
plot(ca(HairEye), main="Hair Color and Eye Color")
title(xlab="Dimension 1 (89.4%)", ylab="Dimension 2 (9.5%)")
par(op)
