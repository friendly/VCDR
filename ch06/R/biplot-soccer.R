# biplot for UKSoccer

data("UKSoccer", package="vcd")
dimnames(UKSoccer) <- list(Home=paste0("H", 0:4), Away=paste0("A", 0:4))

#soccer.ca <- ca(log(UKSoccer+1))

soccer.ca <- ca(UKSoccer)

res <- plot(soccer.ca, map="symbiplot")
res <- plot(soccer.ca, map="rowprincipal")

rscores <- res$rows
cscores <- res$cols

#abline(lm(Dim2 ~ Dim1, data=data.frame(rscores)), col="blue")
#abline(lm(Dim2 ~ Dim1, data=data.frame(cscores)), col="red")

#abline(h=colMeans(rscores[-3,])[2], col="blue")
#abline(v=colMeans(cscores[-3,])[1], col="red")

rmean <- colMeans(rscores[-3,])[2]
cmean <- colMeans(cscores[-3,])[1]
biplot(rscores, cscores, col=c("blue", "red"), cex=1.2, var.axes=FALSE)


points(rscores, col="blue")

abline(h=rmean, col="blue", lwd=2)
abline(v=cmean, col="red", lwd=2)

points(rscores[,1], rmean, col="blue")

##########################################
# use prcomp on log frequency -- this gives what I want

soccer.pca <- prcomp(log(UKSoccer+1), center=TRUE, scale.=FALSE)

round(100*soccer.pca$sdev^2/sum(soccer.pca$sdev^2),2)

biplot(soccer.pca, scale=0, var.axes=FALSE, 
	col=c("blue", "red"), cex=1.2, cex.lab=1.2, 
	xlab="Dimension 1", ylab="Dimension 2")

# get the row and column scores
rscores <- soccer.pca$x[,1:2]
cscores <- soccer.pca$rotation[,1:2]

rmean <- colMeans(rscores[-3,])[2]
cmean <- colMeans(cscores[-3,])[1]

abline(h=rmean, col="blue", lwd=2)
abline(v=cmean, col="red", lwd=2)
abline(h=0, lty=3, col="gray")
abline(v=0, lty=3, col="gray")


#########################################

# analysis of Pearson residuals

soc.P    <- as.matrix(UKSoccer/sum(UKSoccer))
soc.r    <- apply(soc.P,1,sum)
soc.c    <- apply(soc.P,2,sum)
soc.Drmh <- diag(1/sqrt(soc.r))
soc.Dcmh <- diag(1/sqrt(soc.c))
soc.res  <- soc.Drmh%*%(soc.P-soc.r%o%soc.c)%*%soc.Dcmh
dimnames(soc.res) <- dimnames(UKSoccer)
soc.res

# chisq value
sum(soc.res^2) * sum(UKSoccer)

# use loglm
soc.mod <- loglm(~Home + Away, data=UKSoccer)
soc.res2 <- residuals(soc.mod, type="pearson")
sum(soc.res2^2)

soc.pca <- prcomp(soc.res, center=TRUE, scale.=FALSE)
soc.pca <- prcomp(soc.res)
biplot(soc.pca, scale=0,
	col=c("blue", "red"), cex=1.2, cex.lab=1.2, 
	xlab="Dimension 1", ylab="Dimension 2"




