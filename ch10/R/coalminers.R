data("CoalMiners", package="vcd")

ftable(CoalMiners, row.vars=3)


coalminers <- data.frame(t(matrix(aperm(CoalMiners, c(2,1,3)), 4, 9)))
colnames(coalminers) <- c("BW", "Bw", "bW", "bw")
coalminers$age <- c(22, 27, 32, 37, 42, 47, 52, 57, 62)
#coalminers <- transform(coalminers, Age=(age-42)/5)
coalminers

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

logitsCM <- blogits(coalminers[,1:4])
colnames(logitsCM)[1:2] <- c("logitB", "logitW")
logitsCM


# reproduce Fig 7.25

col <- c("blue", "red", "black")
pch <- c(15, 17, 16)
age <- coalminers$age

op <- par(mar=c(4, 4, 1, 4)+.2)
matplot(age, logitsCM, type="p", 
  col=col, pch=pch, cex=1.2, cex.lab=1.25,
  xlab="Age", ylab="Log Odds or Odds Ratio")
abline(lm(logitsCM[,1] ~ age), col=col[1], lwd=2)
abline(lm(logitsCM[,2] ~ age), col=col[2], lwd=2)
abline(lm(logitsCM[,3] ~ age), col=col[3], lwd=2)

# right probability axis
probs <- c(.01, .05, .10, .25, .5)
axis(4, at=qlogis(probs), labels=probs)
mtext("Probability", side=4, cex=1.2, at=-2, line=2.5)
# curve labels
text(age[2], logitsCM[2,1]+.5, "Breathlessness", col=col[1], pos=NULL, cex=1.2)
text(age[2], logitsCM[2,2]+.5, "Wheeze", col=col[2], pos=NULL, cex=1.2)
text(age[2], logitsCM[2,3]-.5, "log OR\n(B|W)/(B|w)", col=col[3], pos=1, cex=1.2)
par(op)

##################################

library(VGAM)
#data("coalminers", package="VGAM")
#colnames(coalminers)[1:4] <- c("BW", "Bw", "bW", "bw")

coalminers <- transform(coalminers, Age=(age-42)/5)
coalminers


# bivariate logit model; NB: order is 00, 01, 10, 11
cm.mod1 <- vglm(cbind(bw, bW, Bw, BW) ~Age, binom2.or(zero=NULL), data=coalminers)

summary(cm.mod1)


#fit <- fitted(cm.mod1)
#colnames(fit) <- c("bw", "bW", "Bw", "BW")
#fit <- cbind(age=coalminers$age, fit)
#fit

age <- coalminers$age
P <- fitted(cm.mod1)
colnames(P) <- c("bw", "bW", "Bw", "BW")
Y <- depvar(cm.mod1)

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


#############################################################
# reproduce Fig 7.25

logitsY1 <- -log( (Y[,1] + Y[,2]) / (Y[,3] + Y[,4]) )
logitsY2 <- -log( (Y[,1] + Y[,3]) / (Y[,2] + Y[,4]) )
logitsY12 <- log( (Y[,1] * Y[,4]) / ((Y[,2] * Y[,3])) )
logits <- cbind(logitsY1, logitsY2, logitsY12)


# NB: these give the same
logitsP <- blogits(P)
logitsY <- blogits(Y)

col <- c("blue", "red", "black")
pch <- c(15, 17, 16)
matplot(age, logitsP, type="p", 
  col=col, pch=pch, cex=1.2, cex.lab=1.25,
  xlab="Age", ylab="Log Odds or Odds Ratio")
abline(lm(logitsP[,1] ~ age), col=col[1], lwd=2)
abline(lm(logitsP[,2] ~ age), col=col[2], lwd=2)
abline(lm(logitsP[,3] ~ age), col=col[3], lwd=2)

text(age[2], logitsP[2,1]+.5, "Breathlessness", col=col[1], pos=NULL, cex=1.2)
text(age[2], logitsP[2,2]+.5, "Wheeze", col=col[2], pos=NULL, cex=1.2)
text(age[2], logitsP[2,3]-.5, "log OR\n(BW)/(Bw)", col=col[3], pos=1, cex=1.2)




# other models 

cm.mod2 <- vglm(cbind(bw, bW, Bw, BW) ~Age + I(Age^2), binom2.or(zero=NULL), data=coalminers)
summary(cm.mod2)




