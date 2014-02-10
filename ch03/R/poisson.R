# poisson distributions


XL <-expand.grid(x=0:20, lambda=c(1, 4, 10))
pois.df <- data.frame(XL, prob=dpois(XL[,"x"], XL[,"lambda"]))
pois.df$lambda = factor(pois.df$lambda)
str(pois.df)


library(lattice)

mycol <- palette()[2:4]
xyplot( prob ~ x, data=pois.df, groups=lambda,
	xlab=list('Number of events (k)', cex=1.25),
	ylab=list('Probability',  cex=1.25),
	type='b', pch=15:17, lwd=2, cex=1.25, col=mycol,
	key = list(
					title = 'lambda',
					points = list(pch=15:17, col=mycol, cex=1.25),
					lines = list(lwd=2, col=mycol),
					text = list(levels(pois.df$lambda)),
					x=0.9, y=0.98, corner=c(x=1, y=1)
					)
	)

# multi-panel versions
xyplot( prob ~ x | lambda, data=pois.df,
	xlab=list('Number of events (k)', cex=1.25),
	ylab=list('Probability',  cex=1.25),
	type='b', lwd=2, cex=1.25, layout=c(3,1))

# histogram-like
xyplot( prob ~ x | lambda, data=pois.df,
	xlab=list('Number of events (k)', cex=1.25),
	ylab=list('Probability',  cex=1.25),
	type=c('h', 'p'), pch=16, lwd=4, cex=1.25, layout=c(3,1))
	
#	key = list(
#					title = 'lambda',
#					points = list(pch=15:17, col=mycol, cex=1.25),
#					lines = list(lwd=2, col=mycol),
#					text = list(levels(pois.df$lambda)),
#					x=0.9, y=0.98, corner=c(x=1, y=1)
#					)
	)


mycol <- palette()[2:4]
plt <-xyplot( prob ~ x, data=pois.df, groups=lambda,
	xlab=list('Number of events (k)', cex=1.25),
	ylab=list('Probability',  cex=1.25),
	type='b', pch=15:17, lwd=2, cex=1.25, col=mycol,
	)
	
library(directlabels)

#direct.label(plt)
direct.label(plt, list("top.points", cex=1.5, dl.trans(y=y+0.1)))

library(ggplot2)

# ggplot(pois.df, aes(x=x, y=prob, colour=lambda)) + geom_line(size=2) + geom_point()

gplt <- ggplot(pois.df, aes(x=x, y=prob, colour=lambda, shape=lambda)) + 
	geom_line(size=1) + geom_point(size=3) +
	xlab("Number of events (k)") +
	ylab("Probability")

gplt + theme(legend.position=c(0.8,0.8)) +  # manually move legend
       theme(axis.text=element_text(size=12),
            axis.title=element_text(size=14,face="bold"))
 
direct.label(gplt, list("top.points", cex=1.5, dl.trans(y=y+0.15)))

	

You can change axis text and label size with arguments axis.text= and axis.title= in function theme(). 
If you need, for example, change only x axis title size, then use axis.title.x=.

plt + theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14,face="bold"))
        
	
	
	


