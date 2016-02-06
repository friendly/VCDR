data("CodParasites", package = "countreg")

# omit NAs in response
CodParasites <- subset(CodParasites, !is.na(intensity))

# drop sex==0
CodParasites <- subset(CodParasites, sex !=0)
CodParasites$sex <- factor(CodParasites$sex, labels=c("male", "female"))

#levels(CodParasites$sex) <- c("male", "female")

str(CodParasites)


library(vcdExtra)

library(gpairs)
gpairs(CodParasites[, c(1,2,5,6,7,8)],
	diag.pars=list(fontsize=16),
	mosaic.pars=list(gp=shading_Friendly)
	)


## exploratory displays for prevalence
op <-par(mfrow = c(2, 2), mar=c(4,4,1,1)+.1)
plot(prevalence ~ depth, data = CodParasites)
plot(prevalence ~ weight, data = CodParasites)
plot(prevalence ~ length, data = CodParasites)
plot(prevalence ~ sex, data = CodParasites)
par(op)

CPpos <- subset(CodParasites, intensity>0 & !is.na(length))

# base graphics plot, log scale + smooth + lm line
with(CPpos, {
	plot(jitter(intensity) ~ depth, log = "y", ylab="Intensity (log scale)")
	lines(lowess(depth, exp(log(intensity))), col="red", lwd=2)
	lines(CPpos$depth, exp( lm(log(intensity) ~ depth)$fitted), lwd=2)
	})

with(CPpos, {
	plot(jitter(intensity) ~ length, log = "y", ylab="Intensity (log scale)")
	lines(lowess(length, exp(log(intensity))), col="red", lwd=2)
	lines(CPpos$length, exp( lm(log(intensity) ~ length)$fitted), lwd=2)
	})


library(ggplot2)
ggplot(CPpos, aes(x=depth, y=intensity)) +
	geom_jitter(position=position_jitter(height=.1), alpha=0.25) + 
	geom_rug(position='jitter', sides='b') +
	scale_y_log10(breaks=c(1,2,5,10,20,50,100, 200)) +
	stat_smooth(method="loess", color="red", fill="red", size=2) +
	stat_smooth(method="lm", size=1.5) + theme_bw() +
	labs(y='intensity (log scale)')

ggplot(CPpos, aes(x=length, y=intensity)) +
	geom_jitter(position=position_jitter(height=.1), alpha=0.25) + 
	geom_rug(position='jitter', sides='b') +
	scale_y_log10(breaks=c(1,2,5,10,20,50,100, 200)) +
	stat_smooth(method="loess", color="red", fill="red", size=2) +
	stat_smooth(method="lm", size=1.5) + theme_bw() +
	labs(y='intensity (log scale)')
