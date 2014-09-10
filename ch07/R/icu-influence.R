library(vcdExtra)
data("ICU", package="vcdExtra")

# remove redundant variables (race, coma)
ICU <- ICU[,-c(4, 20)]

icu.glm2 <- glm(died ~ age + cancer  + admit + uncons, data=ICU, family=binomial)

library(car)
res <- influencePlot(icu.glm2, id.col="red", scale=8, id.cex=1.5, id.n=3)
res

idx <- which(rownames(ICU) %in% rownames(res))
# show data together with diagnostics
cbind(ICU[idx,c("died", "age", "cancer", "admit", "uncons")], res)

influenceIndexPlot(icu.glm2, vars=c("Cook", "Studentized", "hat"), id.n=4)

# exploring dfbetas

infl <- influence.measures(icu.glm2)
summary(infl)

#dfbetas <- data.frame(infl$infmat[,2:5],died=ICU$died)
dfbetas <- data.frame(infl$infmat[,2:5])
colnames(dfbetas) <- c("dfb.age", "dfb.cancer", "dfb.admit", "dfb.uncons")

## simpler: just use dfbeta() -- no these are scaled differently
## dfbeta uses lm.influence; not for glms
#dfbetas <- dfbeta(icu.glm2)[,-1]
#colnames(dfbetas) <- c("dfb.age", "dfb.cancer", "dfb.admit", "dfb.uncons")


# custom index plot
cols=ifelse (ICU$died=="Yes", "red", "blue")
op <- par(mar=c(5,5,1,1)+.1)
plot(dfbetas[,1], type = "h", col=cols,
  xlab="Observation index", 
  ylab=expression(Delta * beta[Age]), cex.lab=1.3)
points(dfbetas[,1], col=cols)
big <- abs(dfbetas[,1]) > .25
idx <- 1:nrow(dfbetas)
text(idx[big], dfbetas[big,1], label=rownames(dfbetas)[big],
  cex=0.9, pos=ifelse(dfbetas[big,1]>0, 3, 1), 
  xpd=TRUE)
abline(h=c(-.25, 0, .25), col="gray")
par(op)


#pairs(dfbetas, col=cols)

scatterplotMatrix(dfbetas, smooth=FALSE, id.n=2, 
  ellipse=TRUE, levels=0.95, robust=FALSE,
  diagonal="histogram",
  groups=ICU$died, col=c("blue", "red"))
  

scatterplotMatrix(dfbetas, smooth=FALSE, id.n=2, id.method="y",
  ellipse=TRUE, levels=0.95, robust=FALSE,
  diagonal="histogram",
  groups=ICU$died, col=c("blue", "red"))
  










