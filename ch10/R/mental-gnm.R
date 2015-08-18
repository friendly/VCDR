## Mental health data
library(gnm)
library(vcdExtra)
data("Mental", package="vcdExtra")


# fit linear x linear (uniform) association.  Use integer scores for rows/cols 
Cscore <- as.numeric(Mental$ses)
Rscore <- as.numeric(Mental$mental)

linlin <- glm(Freq ~ mental + ses + Rscore:Cscore,
                family = poisson, data = Mental)

# fit RC models

##  Goodman Row-Column association model fits well (deviance 3.57, df 8)
Mental$mental <- C(Mental$mental, treatment)
Mental$ses <- C(Mental$ses, treatment)
indep <- gnm(Freq ~ mental + ses, family = poisson, data = Mental)
RC1 <- update(indep, . ~ . + Mult(mental, ses), verbose=FALSE)
RC2 <- update(indep, . ~ . + instances(Mult(mental, ses),2), verbose=FALSE)

RC1 <- gnm(Freq ~ mental + ses + Mult(mental, ses),
                family = poisson, data = Mental, verbose=FALSE)

long.labels <- list(set_varnames = c(mental="Mental Health Status", ses="Parent SES"))
mosaic(RC1, residuals_type="rstandard",
 labeling_args = long.labels, labeling=labeling_residuals, suppress=1, gp=shading_Friendly,
 legend=FALSE,
 main="Mental health data: RC(1) model")
 
vcdExtra::LRstats(RC1)
#vcdExtra::LRstats(glmlist(indep, linlin, roweff, coleff, RC1))


RC2 <- gnm(Freq ~ mental + ses + instances(Mult(mental, ses),2),
                family = poisson, data = Mental, verbose=FALSE)

#vcdExtra::LRstats(glmlist(indep, linlin, roweff, coleff, RC1, RC2))
# LR tests for equal-interval scores
anova(linlin, RC1, RC2, test="Chisq")

#######################################################
# visualize models

### what is the default normalization???

# normalize scores, according to Agresti 2013, Eq 10.13
rowProbs <- with(Mental, tapply(Freq, mental, sum) / sum(Freq))
colProbs <- with(Mental, tapply(Freq, ses, sum) / sum(Freq))
rowScores <- coef(RC1)[10:13]
colScores <- coef(RC1)[14:19]
rowScores <- rowScores - sum(rowScores * rowProbs)
colScores <- colScores - sum(colScores * colProbs)
beta1 <- sqrt(sum(rowScores^2 * rowProbs))
beta2 <- sqrt(sum(colScores^2 * colProbs))
assoc <- list(beta = beta1 * beta2,
              mu = rowScores / beta1,
              nu = colScores / beta2)
assoc


# grouped dotchart, but no error bars 
scores <- data.frame(score=c(assoc$mu, assoc$nu), 
                     factor=c(rep("mental", 4), rep("ses", 6)))
rownames(scores) <- c(levels(Mental$mental), levels(Mental$ses)) 
scores

op <- par(mar=c(5,4,1,1)+.1)
dotchart(scores$score, groups=scores$factor, labels=rownames(scores), cex=1.2, pch=16, xlab="RC1 Score")
par(op)


###################################################
### code chunk number 28: Elliptical_contrasts
###################################################
rowProbs <- with(Mental, tapply(Freq, mental, sum) / sum(Freq))
colProbs <- with(Mental, tapply(Freq, ses, sum) / sum(Freq))
mu <- getContrasts(RC1, pickCoef(RC1, "[.]mental"),
                   ref = rowProbs, scaleWeights = rowProbs)
nu <- getContrasts(RC1, pickCoef(RC1, "[.]ses"),
                   ref = colProbs, scaleWeights = colProbs)
# extract qvframe
(mu <- mu$qvframe)
(nu <- nu$qvframe)

scores <- rbind(mu, nu)
scores <- cbind(scores,
                factor=c(rep("mental", 4), rep("ses", 6)) )
rownames(scores) <- c(levels(Mental$mental), levels(Mental$ses)) 
scores$lower <- scores[,1]-scores[,2]
scores$upper <- scores[,1]+scores[,2]
scores

# dotchart with error bars 
op <- par(mar=c(5,4,1,1)+.1)
with(scores, {
  dotchart(Estimate, groups=factor, labels=rownames(scores), cex=1.2, pch=16, xlab="RC1 Score",
           xlim=c(min(lower), max(upper)))
  arrows(lower, c(8+(1:4), 1:6), upper, c(8+(1:4), 1:6), col="red", angle=90, length=.05, code=3, lwd=2) 
  })
par(op)

dev.copy2pdf(file="mental-RC1.pdf")


#################################################
  
## How do to this for the RC2 model?

mu1 <- getContrasts(RC2, pickCoef(RC2, "1)[.]mental"),  ref = rowProbs, scaleWeights = rowProbs)
#Warning message:
#None of the specified contrasts is estimable 
#> 

mu2 <- getContrasts(RC2, pickCoef(RC2, "2)[.]mental"))
#Warning message:
#None of the specified contrasts is estimable 
#> 

alpha <- coef(RC2)[pickCoef(RC2, "[.]mental")]
alpha <- matrix(alpha, ncol=2)
rownames(alpha) <- levels(Mental$mental)
colnames(alpha) <- c("Dim1", "Dim2")
alpha

beta <- coef(RC2)[pickCoef(RC2, "[.]ses")]
beta <- matrix(beta, ncol=2)
rownames(beta) <- levels(Mental$ses)
colnames(beta) <- c("Dim1", "Dim2")
beta

# scaling: is this correct?

alpha <- apply(alpha, 2, function(x) x-sum(x*rowProbs))
alpha <- apply(alpha, 2, function(x) x/sqrt(sum(x^2 * rowProbs)))
beta <- apply(beta, 2, function(x) x-sum(x*colProbs))
beta <- apply(beta, 2, function(x) x/sqrt(sum(x^2 * colProbs)))

# or, use 0,1 scaling

alpha <- scale(alpha)
beta <- scale(beta)


t(alpha) %*% alpha
t(beta) %*% beta
colMeans(alpha)
colMeans(beta)

scores <- data.frame(rbind(alpha,beta))
scores$factor <- c(rep("mental", 4), rep("ses", 6))
scores$probs <- c(rowProbs, colProbs)
scores


library(lattice)

xyplot(Dim2 ~ Dim1, groups=factor, data=scores, type="b", 
    cex=1.3, pch=16, lwd=2, aspect="iso",
      panel=function(x, y, ...) {
               panel.xyplot(x, y, ...)
               panel.text(x=x, y=y, labels=rownames(scores), pos=1, cex=1.2)
               panel.abline(h=0, col="gray")
               panel.abline(v=0, col="gray")
               }
  )

dev.copy2pdf(file="mental-RC2.pdf")



