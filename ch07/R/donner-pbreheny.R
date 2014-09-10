# from http://web.as.uky.edu/statistics/users/pbreheny/760/S11/notes/4-12.R

#donner <- read.delim("../../data/donner.txt")
#Female <- 1*(donner$Sex=="Female")
#fit <- glm(Status~Age*Sex,donner,family="binomial")
#fit2 <- glm(Status~Age*Female,donner,family="binomial")

data("Donner", package="vcdExtra")

# make survived a factor
Donner$survived <- factor(Donner$survived, labels=c("no", "yes"))

fit <- glm(survived ~ poly(age,2) + sex, data=Donner, family="binomial")

df <- data.frame(Donner[,2:4],Leverage=hatvalues(fit),
	Cook=cooks.distance(fit),
#	db1=dfbeta(fit)[,2], db2=dfbeta(fit2)[,3],
	pi=fit$fitted.values,
	resid=rstudent(fit)
	)

library(lattice)
xyplot(Leverage~age|sex,df,type="h",
	lwd=2,ylim=c(-0.02,max(df$Leverage)+.02))

xyplot(Cook~age|sex,df,
	type="h",lwd=2,group=survived,
	auto.key=list(columns=2,points=FALSE,lines=TRUE),ylab="Cook's distance")

xyplot(db1~age,df,
	subset=(sex=="Female"),main="Female",type="h",lwd=2,group=Status,
	auto.key=list(columns=2,points=FALSE,lines=TRUE),ylab=expression(Delta[beta]))

xyplot(db2~age,df,
	subset=(sex=="Male"),main="Male",type="h",lwd=2,group=Status,
	auto.key=list(columns=2,points=FALSE,lines=TRUE),ylab=expression(Delta[beta]),ylim=range(df$db1))

plot(fit$fitted.values,rstudent(fit),pch=19, cex=2*infl$hat/max(infl$hat), 
xlab=expression(pi),ylab=expression(d*"(Studentized deleted)"),col=col)

plot(fit$fitted.values,rstudent(fit)^2,pch=19, cex=2*infl$hat/max(infl$hat), 
xlab=expression(pi),ylab=expression(d^2*"(Studentized deleted)"),col=col)