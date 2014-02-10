# linear regressions of CA

haireye <- margin.table(HairEyeColor, 1:2)

library(ca)

(haireye.ca <- ca(haireye))

rowc <- haireye.ca$rowcoord[,1:2]   # hair colors
colc <- haireye.ca$colcoord[,1:2]   # eye colors
y1 <- rep(rowc[,1], 4)
y2 <- rep(rowc[,2], 4)
x1 <- rep(colc[,1], each=4)
x2 <- rep(colc[,2], each=4)

df <- data.frame(haireye, x1, x2, y1, y2)

# order alphabetically

df$hair <- rep(order(levels(df$Hair)), 4)
df$eye <- rep(order(levels(df$Eye)), each=4)

library(vcdExtra)

dft <- expand.dft(df)   # weight by Freq
# correlations of CA scored categories
cor(dft[,c("x1","x2")], dft[,c("y1", "y2")])
zapsmall(cor(dft[,c("x1","x2")], dft[,c("y1", "y2")]))

#plot(y1 ~ x1, df)
#text(df$x1, df$y1, df$Freq, adj=c(0,1))

modY <- lm(y1 ~ x1, data=dft)
modX <- lm(x1 ~ y1, data=dft)

# Reproduce fig 5.6 in vcd
### this is not correct yet ###
with(df, {
	symbols(x1, y1, circles=sqrt(Freq/800), inches=FALSE,
	        ylim=c(-2,2), xlim=c(-1.5, 1.5),
	        xlab="X1 (Eye color)", ylab="Y1 (Hair color)")
	text(x1, y1, Freq)
	abline(modY, col="red")
	abline(modX, col="blue")
	text(0, y1[1:4], df$Hair[1:4], col="red")
	text(x1[4*1:4], -2, df$Eye[4*(1:4)], col="blue")
	}
	)
	
# Reproduce fig 5.5 in vcd
### this is not correct yet ###

ymeans <- aggregate(hair ~ eye, data=dft, FUN=mean)
xmeans <- aggregate(eye ~ hair, data=dft, FUN=mean)

H <- order(levels(df$Hair))
E <- order(levels(df$Eye))
with(df, {
	plot(eye, hair,  cex=sqrt(Freq/10),
	     xlim=c(0,4), ylim=c(0,4))
	lines(ymeans[,2:1], col="red", lwd=2, type="b", cex=1.5, pch=16)
	lines(xmeans, col="blue", lwd=2, type="b", cex=1.5, pch=16)
	text(0, 1:4, df$Hair[H], col="red")
	text(1:4, 0, df$Eye[4*E], col="blue")
	text(eye, hair, Freq, adj=c(0,1))
	})



