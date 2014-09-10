library(vcdExtra)
library(ca)

data(Mental)
Mental.tab <- xtabs(Freq ~ mental+ses, data=Mental)
ca(Mental.tab)
plot(ca(Mental.tab))
title(xlab='Dim 1', ylab='Dim 2')

