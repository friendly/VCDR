library(car)    # for Anova()
data(UCBAdmissions)
berkeley <- as.data.frame(UCBAdmissions)
berk.logit1 <- glm(Admit=="Admitted" ~ Dept, data=berkeley, weights=Freq, family="binomial")
Anova(berk.logit1)
summary(berk.logit1)

berk.logit2 <- glm(Admit=="Admitted" ~ Dept+Gender, data=berkeley, weights=Freq, family="binomial")
Anova(berk.logit2)
summary(berk.logit2)

# include a 1 df term for dept A
berkeley <- within(berkeley, dept1AG <- (Dept=='A')*(Gender=='Female'))
berk.logit3 <- glm(Admit=="Admitted" ~ Dept+Gender+dept1AG, data=berkeley, weights=Freq, family="binomial")
summary(berk.logit3)
Anova(berk.logit3)
anova(berk.logit3)


############################################

library(effects)   ## load the effects package
berk.eff2 <- allEffects(berk.logit2)
# plot main  effects
plot(berk.eff2)
# plot 'interaction'
#plot(effect('Dept:Gender', berk.logit2), multiline=TRUE)

plot(Effect(c('Dept', 'Gender'), berk.logit2), multiline=TRUE, key.args=list(x=.7, y=.9))

## can't use effects for this
#plot(effect('Dept:Gender', berk.logit3), multiline=TRUE)
plot(Effect(c('Dept', 'Gender'), berk.logit3), multiline=TRUE, key.args=list(x=.7, y=.9))

###################################
# plotting with ggplot2

# observed logits
obs <- log(UCBAdmissions[1,,] / UCBAdmissions[2,,])
pred2 <- cbind(berkeley[,1:3], fit=predict(berk.logit2))
pred2 <- cbind(subset(pred2, Admit=="Admitted"), obs=as.vector(obs))
head(pred2)

library(ggplot2)

ggplot(pred2, aes(x=Dept, y=fit, group=Gender, color=Gender)) +
  geom_line(size=1.2) +
  geom_point(aes(x=Dept, y=obs, group=Gender, color=Gender), size=4) +
  ylab("Log odds (Admitted)") + theme_bw() + 
  theme(legend.position=c(.8, .9), 
        legend.title=element_text(size=14),
        legend.text=element_text(size=14))

dev.copy2pdf(file="berk-logit2.pdf")

pred3 <- cbind(berkeley[,1:3], fit=predict(berk.logit3))
pred3 <- cbind(subset(pred3, Admit=="Admitted"), obs=as.vector(obs))
head(pred3)

ggplot(pred3, aes(x=Dept, y=fit, group=Gender, color=Gender)) +
  geom_line(size=1.2) +
  geom_point(aes(x=Dept, y=obs, group=Gender, color=Gender), size=4) +
  ylab("Log odds (Admitted)") + theme_bw() + 
  theme(legend.position=c(.8, .9), 
        legend.title=element_text(size=14),
        legend.text=element_text(size=14))

dev.copy2pdf(file="berk-logit3.pdf")
