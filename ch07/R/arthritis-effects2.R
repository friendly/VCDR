data("Arthritis", package="vcd")
Arthritis <- transform(Arthritis, Better = Improved > "None")
arth.logistic2 <- glm(Better ~ I(Age - 50) + Sex + Treatment,
                      data = Arthritis, family = binomial)

library(effects)
arth.eff2 <- allEffects(arth.logistic2, partial.residuals=TRUE)
names(arth.eff2)

# illustrate efflist objects
arth.eff2[["Sex"]]
arth.eff2[["Sex"]]$model.matrix



plot(arth.eff2, rescale.axis=FALSE, colors=c("red", "blue"), lwd=3, residuals.pch=15, rows=1, cols=3)

arth.eff1 <- Effect("Age", arth.logistic2, partial.residuals=TRUE)
plot(arth.eff1, rescale.axis=FALSE, residuals.pch=15)

plot(arth.eff1, type="link", ylim=c(-4,4), colors=c("red", "blue"), lwd=3)


arth.eff2 <- Effect(c("Age", "Treatment"), arth.logistic2, partial.residuals=TRUE)
plot(arth.eff2, rescale.axis=FALSE, residuals.pch=15, cex=2)



library(visreg)
# needs a wide plot window for all three plots
op <- par(mfrow=c(1,3), mar=c(4,4,0.5,1)+.1, cex.lab=1.5)
visreg(arth.logistic2,	points.par=list(cex=1), fill=list(col="lightblue"), line=list(lwd=4), ylab="logit(Better)")
par(op)


library(vcd)
binreg_plot(arth.logistic2)

