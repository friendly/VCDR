library(vcdExtra)
data("Toxaemia", package="vcdExtra")
#tox.tab <- xtabs(Freq~class + smoke + hyper + urea, Toxaemia)


# loglinear model
#tox.mod1 <- glm(Freq ~ class*smoke + hyper*urea + class:hyper + hyper:urea, data=Toxaemia, family=poisson)

# models from VCD
# null model
tox.glm0 <- glm(Freq ~ class*smoke + hyper + urea , data=Toxaemia, family=poisson)

# baseline model: no association between predictors and responses
tox.glm1 <- glm(Freq ~ class*smoke + hyper*urea , data=Toxaemia, family=poisson)

tox.glm2 <- update(tox.glm1, . ~ . + smoke*hyper + class*urea)

tox.glm3 <- glm(Freq ~ (class + smoke + hyper + urea)^2 , data=Toxaemia, family=poisson)

tox.glm4 <- glm(Freq ~ class*smoke*hyper + hyper*urea + class*urea, data=Toxaemia, family=poisson)

tox.glm5 <- update(tox.glm4, . ~ . + smoke*urea)

tox.glm6 <- update(tox.glm4, . ~ . + class*smoke*urea)

tox.glm7 <- update(tox.glm6, . ~ . + smoke*hyper*urea)

tox.glm8 <- glm(Freq ~ (class + smoke + hyper + urea)^3 , data=Toxaemia, family=poisson)

tox.glm9 <- glm(Freq ~ (class + smoke + hyper + urea)^4 , data=Toxaemia, family=poisson)

mods <- glmlist(tox.glm0, tox.glm1, tox.glm2, tox.glm3, 
                tox.glm4, tox.glm5, tox.glm6, tox.glm7, tox.glm8, tox.glm9)
summarise(mods)

# AIC and BIC for a list of models

aic <- AIC(tox.glm0, tox.glm1, tox.glm2, tox.glm3, 
           tox.glm4, tox.glm5, tox.glm6, tox.glm7, tox.glm8, tox.glm9)
bic <- BIC(tox.glm0, tox.glm1, tox.glm2, tox.glm3, 
           tox.glm4, tox.glm5, tox.glm6, tox.glm7, tox.glm8, tox.glm9)
merge(aic,bic, by=c(0,1))


library(lmtest)
lrt <- lrtest(tox.glm0, tox.glm1, tox.glm2, tox.glm3, 
       tox.glm4, tox.glm5, tox.glm6, tox.glm7, tox.glm8, tox.glm9)

lrtest(tox.glm1, tox.glm2, tox.glm3, tox.glm4, tox.glm5)
   
# backward elimination
tox.aic <- stepAIC(tox.glm9, scope=list(lower= ~ class*smoke + hyper*urea), trace=0)

mods <- glmlist(tox.glm0, tox.glm1, tox.glm2, tox.aic, tox.glm3, 
                tox.glm4, tox.glm5, tox.glm6, tox.glm7, tox.glm8, tox.glm9)
summarise(mods)


library(car)
Anova(tox.glm2)
Anova(tox.glm3)
Anova(tox.glm4)

### observed logits and logOR, with ggplot2
## NB: makes a good exercise in Ch 2

# reshape to 15 x 4 table of frequencies
tox.tab <- xtabs(Freq~class + smoke + hyper + urea, Toxaemia)
toxaemia <- t(matrix(aperm(tox.tab), 4, 15))
colnames(toxaemia) <- c("hu", "hU", "Hu", "HU")
rowlabs <- expand.grid(smoke=c("0", "1-19", "20+"), class=factor(1:5))
toxaemia <- cbind(toxaemia, rowlabs)

# observed logits and log odds ratios
logitsTox <- blogits(toxaemia[,4:1], add=0.5)
colnames(logitsTox)[1:2] <- c("logitH", "logitU")
logitsTox <- cbind(logitsTox, rowlabs)

pred <- cbind(Toxaemia, fit=predict(tox.glm2, type="response"))
head(pred, 12)

# fitted frequencies, as a 15 x 4 table
Fit <- t(matrix(predict(tox.glm2, type="response"), 4, 15))
colnames(Fit) <- c("HU", "Hu", "hU", "hu")
Fit <- cbind(Fit, rowlabs)
Fit
logitsFit <- blogits(Fit[,1:4], add=0.5)
colnames(logitsFit)[1:2] <- c("logitH", "logitU")
logitsFit <- cbind(logitsFit, rowlabs)

matrix(logitsFit$logOR, 3, 5, dimnames=list(smoke=c("0", "1-19", "20+"), class=1:5))

library(ggplot2)
#library(directlabels)

ggplot(logitsFit, aes(x=as.numeric(class), y=logitH, color=smoke)) + 
  theme_bw() +
  geom_line(size=1.2) +
  scale_color_manual(values=c("blue", "black", "red")) +
  ylab("log odds (Hypertension)") +
  xlab("Social class of mother") +
  ggtitle("Hypertension") +
  theme(axis.title=element_text(size=16)) +
  geom_point(data=logitsTox, aes(x=as.numeric(class), y=logitH, color=smoke), size=3) +
  theme(legend.position=c(0.85, .6)) 

dev.copy2pdf(file="tox-glm-logits1.pdf")

#direct.label(gg1 + xlim(1,5.2), list("top", cex=1.5))

ggplot(logitsFit, aes(x=as.numeric(class), y=logitU, color=smoke)) + 
  theme_bw() +
  geom_line(size=1.2) +
  scale_color_manual(values=c("blue", "black", "red")) +
  ylab("log odds (Urea)") +
  xlab("Social class of mother") +
  ggtitle("Urea") +
  theme(axis.title=element_text(size=16)) +
  geom_point(data=logitsTox, aes(x=as.numeric(class), y=logitU, color=smoke), size=3) +
  theme(legend.position=c(0.85, .3)) 

dev.copy2pdf(file="tox-glm-logits2.pdf")


ggplot(logitsFit, aes(x=as.numeric(class), y=logOR, color=smoke)) + 
  theme_bw() +
  geom_line(size=1.2) +
  scale_color_manual(values=c("blue", "black", "red")) +
  ylab("log odds ratio (Hypertension | Urea)") +
  xlab("Social class of mother") +
  ggtitle("Log Odds Ratio") +
  theme(axis.title=element_text(size=16)) +
  geom_point(data=logitsTox, aes(x=as.numeric(class), y=logOR, color=smoke), size=3) +
  theme(legend.position=c(0.85, .3)) 

dev.copy2pdf(file="tox-glm-logits3.pdf")

#gg3 <- ggplot(logitsFit, aes(x=as.numeric(class), y=logOR, color=smoke)) + 
#  theme_bw() +
#  geom_point(size=3) + geom_line(size=1.2) +
#  ylab("log odds ratio (Hypertension | Urea)") +
#  xlab("Social class of mother") +
#  theme(axis.title=element_text(size=16)) +
#  scale_color_manual(values=c("blue", "black", "red"))
#gg3
#gg3 + geom_point(data=logitsTox, aes(x=as.numeric(class), y=logOR, color=smoke))
#

 
######################################################################

library(VGAM)


#tox.logits <- cbind(blogits(toxaemia[,4:1], add=0.5), rowlabs)

# bivariate logit model; NB: order is 00, 01, 10, 11
tox.vglm1 <- vglm(cbind(hu, hU, Hu, Hu) ~ class + smoke, binom2.or(zero=3), data=toxaemia)
AIC(tox.vglm1)
coef(tox.vglm1, matrix=TRUE)

P <- fitted(tox.vglm1)
colnames(P) <- c("hu", "hU", "Hu", "HU")
Y <- depvar(tox.vglm1)

logitsP <- blogits(P[,4:1])
colnames(logitsP)[1:2] <- c("logitH", "logitU")
logitsP <- cbind(logitsP, rowlabs)

logitsY <- blogits(Y[,4:1], add=0.5)
colnames(logitsY)[1:2] <- c("logitH", "logitU")
logitsY <- cbind(logitsY, rowlabs)

ggplot(logitsP, aes(x=as.numeric(class), y=logitH, color=smoke)) + 
  theme_bw() +
  geom_point(size=3) + geom_line(size=1.2) +
  ylab("log odds (Hypertension)") +
  xlab("Social class of mother") +
  theme(axis.title=element_text(size=16)) +
  scale_color_manual(values=c("blue", "black", "red"))

ggplot(logitsP, aes(x=as.numeric(class), y=logitU, color=smoke)) + 
  theme_bw() +
  geom_point(size=3) + geom_line(size=1.2) +
  ylab("log odds (Urea)") +
  xlab("Social class of mother") +
  theme(axis.title=element_text(size=16)) +
  scale_color_manual(values=c("blue", "black", "red"))


tox.vglm2 <- vglm(cbind(hu, hU, Hu, Hu) ~ class * smoke, binom2.or(zero=3), data=toxaemia)
AIC(tox.vglm2)
coef(tox.vglm2, matrix=TRUE)

#lrtest(tox.vglm1, tox.vglm2)

