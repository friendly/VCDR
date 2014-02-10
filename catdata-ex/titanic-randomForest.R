load("c:/sasuser/catdata/R/data/ptitanic.rda")
library(vcdExtra)
data(Titanicp, package="vcdExtra")

library(randomForest)
# random forest
titanic.rf = randomForest(as.factor(survived) ~ pclass + sex + age + sibsp, 
	data=titanic3, ntree=1000, importance=TRUE, na.action=na.omit)

imp <- importance(titanic.rf)
impvar <- rownames(imp)[order(imp[, 1], decreasing=TRUE)]
op <- par(mfrow=c(2, 2))
for (i in seq_along(impvar)) {
    partialPlot(titanic.rf, titanic3, impvar[i], xlab=impvar[i],
                main=paste("Partial Dependence on", impvar[i]),
                ylim=c(30, 70))
}
par(op)

partialPlot(titanic.rf, titanic3, "pclass", which.class=1)
partialPlot(titanic.rf, titanic3, "sex", which.class=1)
partialPlot(titanic.rf, titanic3, "age", which.class=1)
partialPlot(titanic.rf, titanic3, "sibsp", which.class=1)

