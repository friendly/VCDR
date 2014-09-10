install.packages("vcdExtra", repos="http://R-Forge.R-project.org")
library(vcdExtra)
data("ICU", package="vcdExtra")

library(rms)
dd <- datadist(ICU[,-1])
options(datadist="dd")

icu.lrm2 <- lrm(died ~ age + cancer  + admit + uncons, data=ICU)

plot(nomogram(icu.lrm2), cex.var=1.2, lplabel="Log odds death")

# try to add a probability scale
plot(nomogram(icu.lrm2, fun=plogis, funlabel="Probability of death"), 
	cex.var=1.2, lplabel="Log odds death")


