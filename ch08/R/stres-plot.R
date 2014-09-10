# demonstrate dependence of std errors of residuals on fitted values

berkeley <- as.data.frame(UCBAdmissions)
berk.glm1 <- glm(Freq ~ Dept * (Gender+Admit), data=berkeley, family="poisson")
fit <- fitted(berk.glm1)
hat <- hatvalues(berk.glm1)
stderr <- sqrt(1-hat)

op <- par(mar=c(5,4,1,1)+.1)
plot(fit, stderr, cex = 5*hat, 
  ylab="Std. Error of Residual", xlab="Fitted Frequency",
  cex.lab=1.2)
labs <- with(berkeley, 
  paste(Dept, substr(Gender,1,1), ifelse(Admit=="Admitted", "+", "-"), sep=""))
col <- ifelse(berkeley$Admit=="Admitted", "blue", "red")
#col <- ifelse(berkeley$Gender=="Male", "blue", "red")
text(fit, stderr, labs, col=col, cex=1.2)
par(op)

