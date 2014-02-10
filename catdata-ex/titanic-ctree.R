# after: http://www.r-bloggers.com/binary-classification-a-comparison-of-titanic-proportions-between-logistic-regression-random-forests-and-conditional-trees/

data(Titanicp, package="vcdExtra")

# rpart trees

library(rpart)
library(rpart.plot)
data(Titanicp, package="vcdExtra")
# remove missings on age ??? maybe not necessary
#Titanicp <- Titanicp[!is.na(Titanicp$age),]

# fit a simple tree
rp0 <- rpart(survived ~ pclass + age, data=Titanicp)
rpart.plot(rp0,type=0,extra=2, cex=1.5)

rpart.plot(rp0,type=0,extra=2, cex=1.5)

# pruning
printcp(rp0)
plotcp(rp0, lty=2, col="red", lwd=2)

rp0.pruned <- prune(rp0, cp=.05)
rpart.plot(rp0.pruned, type=0, extra=2, cex=1.5)

rpart.plot(rp0.pruned, type=0, extra=2, cex=1.5, 
           under=TRUE, box.col=c("pink", "lightblue")[rp0.pruned$frame$yval])

# partition map, from Varian, for the pruned tree

with(Titanicp, {
	n <- length(class)
	class <- as.numeric(pclass)
	class.jitter <- jitter(class)
	op <- par(mar=c(4,4,0,0)+.2)
	plot(age ~ class.jitter,xlim=c(.6,3.4), type="n", xlab="Class (jittered)", ylab="Age", xaxt="n", cex.lab=1.5)
	axis(1, at=1:3, cex.axis=1.5)
	abline(v=1.5, col="gray")
	abline(v=2.5, col="gray")
	abline(h=16, col="gray")
	points(age[survived=="died"] ~ class.jitter[survived=="died"],pch=15, cex=1.1, col="red")
	points(age[survived=="survived"] ~ class.jitter[survived=="survived"],pch=16, cex=1.1, col="blue")
	rect(1.5,16,2.5,89,col=rgb(0.5,0.5,0.5,1/4))
	rect(2.5,-5,3.61,89,col=rgb(0.5,0.5,0.5,1/4))
	text(2.5, 76, "predict: died", cex=1.5, col="red")
	text(1.5, 8, "predict: survived", cex=1.5, col="blue")
	par(op)
})

# same, for the unpruned tree

with(Titanicp, {
  n <- length(class)
  class <- as.numeric(pclass)
  class.jitter <- jitter(class)
  op <- par(mar=c(4,4,0,0)+.2)
  plot(age ~ class.jitter,xlim=c(.6,3.4), type="n", xlab="Class (jittered)", ylab="Age", xaxt="n", cex.lab=1.5)
  axis(1, at=1:3, cex.axis=1.5)
  abline(v=1.5, col="gray")
  abline(v=2.5, col="gray")
  abline(h=16, col="gray")
  points(age[survived=="died"] ~ class.jitter[survived=="died"],pch=15, cex=1.1, col="red")
  points(age[survived=="survived"] ~ class.jitter[survived=="survived"],pch=16, cex=1.1, col="blue")
  rect(1.5,16,2.5,89,col=rgb(0.5,0.5,0.5,1/4))
  rect(2.5,-5,3.61,89,col=rgb(0.5,0.5,0.5,1/4))
  rect(0.48,60,1.5,89, col=rgb(0.5,0.5,0.5,1/4) )
  text(2.5, 76, "predict: died", cex=1.5, col="red")
  text(1.5, 8, "predict: survived", cex=1.5, col="blue")
  par(op)
})

# try using plotmo

library(plotmo)

plotmo(rp0, nresponse="survived", degree1=0, type2="image",
	col.image=gray(seq(.6, 1,.05)),
  col.response=ifelse(Titanicp$survived=="died", "red", "blue"),
  pch=ifelse(Titanicp$survived=="died", 15, 16))

plotmo(rp0, nresponse="survived") 

# 3D persp plot only
plotmo(rp0, nresponse="survived", degree1=0, trace=-1)

# produces 2 plots
plotmo(rp0, nresponse="survived", degree1=1:2, degree2=0, trace=-1, do.par=FALSE,
  col.response=ifelse(Titanicp$survived=="died", "red", "blue"),
  pch=ifelse(Titanicp$survived=="died", 15, 16), lwd.degree1=2
	)

# do them separately
plotmo(rp0, nresponse="survived", degree1=1, degree2=0, trace=-1, do.par=FALSE)
plotmo(rp0, nresponse="survived", degree1=2, degree2=0, trace=-1, do.par=FALSE)


# use all three variables
rp = rpart(survived ~ pclass + sex + age, data=Titanicp)

# display cp table
printcp(rp)

summary(rp, cp=.012)

#prp(rp, type=4, extra=7, prefix="Survival\n", faclen=0)
#prp(rp, type=4, extra=2, faclen=0, under=TRUE)

#coloring the boxes
prp(rp, type=4, extra=2, faclen=0, under=TRUE, 
	box.col=c("pink", "lightblue")[rp$frame$yval])

# add sibsp
rp1 = rpart(survived ~ pclass + sex + age + sibsp, data=Titanicp)
rpart.plot(rp1, type=4, extra=2, faclen=0, under=TRUE, cex=1.1,
	box.col=c("pink", "lightblue")[rp1$frame$yval])

plotcp(rp1)
printcp(rp1)
plotmo(rp1, nresponse="survived")

###################################################

# party::ctree trees

library(party)
#titanic.ctree = ctree(survived ~ pclass + sex + age + sibsp, data=Titanicp)
#titanic.ctree
#plot(titanic.ctree)

titanic.ctree = ctree(survived ~ pclass + sex + age, data=Titanicp)
titanic.ctree

#plot(titanic.ctree)

plot(titanic.ctree, 
	tp_args = list(fill = c("blue", "lightgray")),
	ip_args = list(fill = c("lightgreen"))
	)
	
#plot(titanic3$survived ~ as.factor(where(titanic.ctree1)))

# try adding sibsp
titanic.ctree1 = ctree(survived ~ pclass + sex + age + sibsp, data=Titanicp)
#titanic.ctree

#plot(titanic.ctree)

plot(titanic.ctree1, 
     tp_args = list(fill = c("blue", "lightgray")),
     ip_args = list(fill = c("lightgreen"))
)
