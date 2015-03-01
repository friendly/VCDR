#library(vcdExtra)

data("Arthritis", package="vcd")
Arthritis$Better <- as.numeric(Arthritis$Improved > "None")

#rownames(Arthritis) <- Arthritis$ID
arth.logistic2 <- glm(Better ~ Age + Sex + Treatment, data=Arthritis, family=binomial)

library(car)
res <- influencePlot(arth.logistic2, id.col="red", scale=8, id.cex=1.5)
res <- influencePlot(arth.logistic2, id.col="red", scale=8, id.cex=1.5, bg=grey(.90), pch=21)

# show influence stats and data
cbind(Arthritis[rownames(res),-5], res)

influence.measures(arth.logistic2)$infmat[c(1,15,39),]
   
residualPlots(arth.logistic2)

marginalModelPlots(arth.logistic2)

avPlots(arth.logistic2, id.n=2)

influenceIndexPlot(arth.logistic2, vars=c("Cook", "hat"), id.n=3)


crPlots(arth.logistic2, term = ~ Age)
 
crPlots(glm(partic != "not.work" ~ hincome + children, 
	data=Womenlf, family=binomial))
