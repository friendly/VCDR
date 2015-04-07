data("CoalMiners", package="vcd")

coalminers <- data.frame(t(matrix(aperm(CoalMiners, c(2,1,3)), 4, 9)))
colnames(coalminers) <- c("BW", "Bw", "bW", "bw")
coalminers$age <- c(22, 27, 32, 37, 42, 47, 52, 57, 62)

coalminers <- transform(coalminers, agec=(age-42)/5)
coalminers$Age <- dimnames(CoalMiners)[[3]]
coalminers

library(VGAM)
#data("coalminers", package="VGAM")
#colnames(coalminers)[1:4] <- c("BW", "Bw", "bW", "bw")


# bivariate logit model; NB: order is 00, 01, 10, 11
cm.vglm1 <- vglm(cbind(bw, bW, Bw, BW) ~ agec, binom2.or(zero=NULL), data=coalminers)

# the coefficient for ageOR agrees with Agresti
coef(cm.vglm1)
#(Intercept):1 (Intercept):2 (Intercept):3         Age:1         Age:2 
#   -2.2624682    -1.4877603     3.0219085     0.5145103     0.3254455 
#        Age:3 
#   -0.1313647 
#

# Better:

coef(cm.vglm1, matrix=TRUE)
#            logit(mu1) logit(mu2) log(oratio)
#(Intercept) -2.2624682 -1.4877603   3.0219085
#Age          0.5145103  0.3254455  -0.1313647

exp(coef(cm.vglm1, matrix=TRUE))

deviance(cm.vglm1)
cm.vglm1@df.residual

# test residual deviance
1-pchisq(deviance(cm.vglm1), cm.vglm1@df.residual)

summary(cm.vglm1)

# plot fitted values

age <- coalminers$age
P <- fitted(cm.vglm1)
colnames(P) <- c("bw", "bW", "Bw", "BW")
Y <- depvar(cm.vglm1)

col <- c("red", "blue", "red", "blue")
pch <- c(1,2,16,17)

op <- par(mar=c(5,4,1,1)+.1)
matplot(age, P, type="l", 
  col=col,
  lwd=2, cex=1.2, cex.lab=1.2,
  xlab="Age", ylab="Probability",
  xlim=c(20,65))
matpoints(age, Y, 
  pch=pch, cex=1.2, col=col)
# legend
text(64, P[9,]+ c(0,.01, -.01, 0), labels=colnames(P), col=col, cex=1.2)
text(20, P[1,]+ c(0,.01, -.01, .01), labels=colnames(P), col=col, cex=1.2)
par(op)

cd("C:/Documents and Settings/friendly/My Documents/My Dropbox/Documents/VCDR/ch10/fig")
dev.copy2pdf(file="cm-vglm1-prob.pdf")

# plot on logit scale

op <- par(mar=c(5,4,1,1)+.1)
lP <- qlogis(P)
lY <- qlogis(Y)
matplot(age, lP, type="l", 
  col=col,
  lwd=2, cex=1.2, cex.lab=1.2,
  xlab="Age", ylab="Logit",
  xlim=c(20,65))
matpoints(age, lY, 
  pch=pch, cex=1.2, col=col)
# legend
text(64, lP[9,]+ c(0,.01, -.01, 0), labels=colnames(P), col=col, cex=1.2)
text(20, lP[1,]+ c(0,.01, -.01, .01), labels=colnames(P), col=col, cex=1.2)
par(op)

dev.copy2pdf(file="cm-vglm1-logit.pdf")


# Fig 7.25 from the vglm model

# calculate logits and OR
blogits <- function(Y, add=0) {
  Y <- Y + add
  L <- matrix(0, nrow(Y), 3)
  L[,1] <- log( (Y[,1] + Y[,2]) / (Y[,3] + Y[,4]) )
  L[,2] <- log( (Y[,1] + Y[,3]) / (Y[,2] + Y[,4]) )
  L[,3] <- log( (Y[,1] * Y[,4]) / ((Y[,2] * Y[,3])) )
  colnames(L) <- c("logit1", "logit2", "logOR")
  L
}

# blogits, but for B and W
logitsP <- blogits(P[,4:1])
logitsY <- blogits(Y[,4:1])

col <- c("blue", "red", "black")
pch <- c(15, 17, 16)

matplot(age, logitsY, type="p", 
  col=col, pch=pch, cex=1.2, cex.lab=1.25,
  xlab="Age", ylab="Log Odds or Odds Ratio")
abline(lm(logitsP[,1] ~ age), col=col[1], lwd=2)
abline(lm(logitsP[,2] ~ age), col=col[2], lwd=2)
abline(lm(logitsP[,3] ~ age), col=col[3], lwd=2)

text(age[2], logitsP[2,1]+.5, "Breathlessness", col=col[1], pos=NULL, cex=1.2)
text(age[2], logitsP[2,2]+.5, "Wheeze", col=col[2], pos=NULL, cex=1.2)
text(age[2], logitsP[2,3]-.5, "log OR\n(BW)/(Bw)", col=col[3], pos=1, cex=1.2)

################################################################################
# quadratic model

cm.vglm2 <- vglm(cbind(bw, bW, Bw, BW) ~ poly(agec,2), binom2.or(zero=NULL), data=coalminers)
summary(cm.vglm2)

deviance(cm.vglm2)
cm.vglm2@df.residual

# test residual deviance
1-pchisq(deviance(cm.vglm2), cm.vglm2@df.residual)

LR <- deviance(cm.vglm1) - deviance(cm.vglm2)
1 - pchisq(LR, cm.vglm1@df.residual - cm.vglm2@df.residual)

age <- coalminers$age
P <- fitted(cm.vglm2)
colnames(P) <- c("bw", "bW", "Bw", "BW")
Y <- depvar(cm.vglm2)

col <- c("red", "blue", "red", "blue")
pch <- c(1,2,16,17)
matplot(age, P, type="l", 
  col=col,
  lwd=2, cex=1.2, cex.lab=1.2,
  xlab="Age", ylab="Probability",
  xlim=c(20,65))
matpoints(age, Y, 
  pch=pch, cex=1.2, col=col)
# legend
text(64, P[9,]+ c(0,.01, -.01, 0), labels=colnames(P), col=col, cex=1.2)
text(20, P[1,]+ c(0,.01, -.01, .01), labels=colnames(P), col=col, cex=1.2)


# NB: these give the same
# blogits, but for B and W
logitsP <- blogits(P[,4:1])
logitsY <- blogits(Y[,4:1])

col <- c("blue", "red", "black")
pch <- c(15, 17, 16)
op <- par(mar=c(4, 4, 1, 4)+.2)
matplot(age, logitsY, type="p", 
  col=col, pch=pch, cex=1.2, cex.lab=1.25,
  xlab="Age", ylab="Log Odds or Odds Ratio")
lines(age, fitted(lm(logitsP[,1] ~ poly(age,2))), col=col[1], lwd=2)
lines(age, fitted(lm(logitsP[,2] ~ poly(age,2))), col=col[2], lwd=2)
lines(age, fitted(lm(logitsP[,3] ~ poly(age,2))), col=col[3], lwd=2)

# right probability axis
probs <- c(.01, .05, .10, .25, .5)
axis(4, at=qlogis(probs), labels=probs)
mtext("Probability", side=4, cex=1.2, at=-2, line=2.5)
# curve labels

text(age[2], logitsP[2,1]+.5, "Breathlessness", col=col[1], pos=NULL, cex=1.2)
text(age[2], logitsP[2,2]+.5, "Wheeze", col=col[2], pos=NULL, cex=1.2)
text(age[2], logitsP[2,3]-.5, "log OR\n(B|W)/(B|w)", col=col[3], pos=1, cex=1.2)
par(op)

dev.copy2pdf(file="cm-vglm2-blogit.pdf")


