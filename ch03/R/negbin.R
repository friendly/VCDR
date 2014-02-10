# negbinom examples

# from ?dnbinom

x <- 0:15
size <- (1:20)/4
dnb <- outer(x, size, function(x,s) dnbinom(x, s, prob = 0.4))
persp(x, size, dnb,
      xlab = "x", ylab = "s", zlab = "density", theta = 150)
title(tit <- "negative binomial density(x,s, pr = 0.4)  vs.  x & s")

image  (x, size, log10(dnb), main = paste("log [", tit, "]"))
contour(x, size, log10(dnb), add = TRUE)

## Alternative parametrization
x1 <- rnbinom(500, mu = 4, size = 1)
x2 <- rnbinom(500, mu = 4, size = 10)
x3 <- rnbinom(500, mu = 4, size = 100)
h1 <- hist(x1, breaks = 20, plot = FALSE)
h2 <- hist(x2, breaks = h1$breaks, plot = FALSE)
h3 <- hist(x3, breaks = h1$breaks, plot = FALSE)
barplot(rbind(h1$counts, h2$counts, h3$counts),
        beside = TRUE, col = c("red","blue","cyan"),
        names.arg = round(h1$breaks[-length(h1$breaks)]))


x <- 0:15
size <- seq(2,8,0.5)
dnb <- outer(x, size, function(x,s) dnbinom(x, s, prob = 0.4))
persp(x, size, dnb,
      xlab = "x", ylab = "s", zlab = "density", theta = 150)
#title(tit <- "negative binomial density(x,s, pr = 0.4)  vs.  x & s")

# alternative parameterizations

k = 2
n = 2:4
p = .2
dnbinom( k, n,  p)

mu = n*(1-p)/p
mu
dnbinom( k, n, mu=mu)


XN <-expand.grid(k=0:20, n=c(2, 4, 6), p=c(0.2, 0.3, 0.4))
nbin.df <- data.frame(XN, prob=dnbinom(XN[,"k"], XN[,"n"], XN[,"p"]))
nbin.df$n = factor(nbin.df$n)
nbin.df$p = factor(nbin.df$p)
str(nbin.df)

# multi-panel versions
xyplot( prob ~ k | n + p, data=nbin.df,
	xlab=list('Number of failures (k)', cex=1.25),
	ylab=list('Probability',  cex=1.25),
	type=c('h', 'p'), pch=16, lwd=2,
	strip = strip.custom(strip.names=TRUE) 
	)


# find weighted means -- none of this works
by(nbin.df, nbin.df[, c("n","p")],
	function(x) weighted.mean(nbin.df[,"k"], nbin.df[,"prob"]))

with(nbin.df,
 aggregate(by=list(n,p), FUN=weighted.mean(k, prob))
 )

aggregate(cbind(k, prob) ~ n+p, FUN=weighted.mean)

# calculate means = mu (for the entire distribution, k=0, ... \infty) 
NP <- expand.grid(n=c(2, 4, 6), p=c(0.2, 0.3, 0.4))
NP <- within(NP, { mu = n*(1-p)/p })
# show as matrix
matrix(NP$mu, 3, 3, dimnames=list(n=c(2,4,6), p=(2:4)/10))
