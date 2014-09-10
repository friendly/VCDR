library(vcd)
# main effects model
data(Arthritis)
# define Better
Arthritis$Better <- Arthritis$Improved > 'None'
arth.mod1 <- glm(Better ~ Age + Sex + Treatment , data=Arthritis, family='binomial')
Anova(arth.mod1)

# diagnostic plots: "regression quartet"
#setwd("c:/sasuser/catdata/R")
#postscript(file="arthritis-diag1.eps", paper="special", height=6, width=6, onefile=TRUE, horizontal=FALSE)
op <- par(mfrow=c(2,2))
plot(arth.mod1)
par(op)
#dev.off()

library(car)
# influence plot
#postscript(file="arthritis-diag2.eps", paper="special", height=6, width=6, onefile=TRUE, horizontal=FALSE)
influencePlot(arth.mod1, main="Arthritis data: influencePlot")
#dev.off()
