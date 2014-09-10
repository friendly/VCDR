data("PhdPubs", package="vcdExtra")

hist(PhdPubs$articles, breaks=0:19, col="pink", xlim=c(0,20),
     xlab="Number of Articles")

# mean and variance
with(PhdPubs, c(mean=mean(articles), var=var(articles), ratio=var(articles)/mean(articles)))

library(vcd)
rootogram(goodfit(PhdPubs$articles), xlab="Number of Articles", main="Poisson")
rootogram(goodfit(PhdPubs$articles, type="nbinomial"), xlab="Number of Articles", main="Negative binomial")


# Ord_plot thinks this is a log-series distribution
Ord_plot(table(PhdPubs$articles))
