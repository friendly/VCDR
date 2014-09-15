library(countreg)
data("CrabSatellites", package = "countreg")


CrabSatellites <- transform(CrabSatellites,
  color = as.numeric(color))

## exploratory displays for hurdle (= 0 vs. > 0) and counts (> 0)
op <- par(mfrow = c(2, 2))
plot(factor(satellites == 0) ~ width, data = CrabSatellites, breaks = seq(20, 33.5, by = 1.5))
plot(factor(satellites == 0) ~ color, data = CrabSatellites, breaks = 1:5 - 0.5)
plot(jitter(satellites) ~ width, data = CrabSatellites, subset = satellites > 0, log = "y")
plot(jitter(satellites) ~ factor(color), data = CrabSatellites, subset = satellites > 0, log = "y")
par(op)

op <- par(mfrow = c(2, 2))
plot(factor(satellites == 0) ~ weight, data = CrabSatellites, breaks = seq(1, 5.5, by = 0.5), ylevels=2:1)
plot(factor(satellites == 0) ~ color, data = CrabSatellites, breaks = 1:5 - 0.5,  ylevels=2:1)
plot(jitter(satellites) ~ weight, data = CrabSatellites, subset = satellites > 0, log = "y")
plot(jitter(satellites) ~ factor(color), data = CrabSatellites, subset = satellites > 0, log = "y")
par(op)

# use quantiles
op <- par(cex.lab=1.2, mfrow = c(1, 2))
plot(factor(satellites == 0) ~ weight, data = CrabSatellites, breaks = quantile(weight, probs=seq(0,1,.2)), ylevels=2:1, ylab="No satellites")
plot(factor(satellites == 0) ~ color, data = CrabSatellites, breaks = quantile(color, probs=seq(0,1,.33)),  ylevels=2:1, ylab="No satellites")
par(op)


# or, cdplot
op <- par(cex.lab=1.2, mfrow = c(1, 2))
cdplot(factor(satellites == 0) ~ weight, data = CrabSatellites, ylevels=2:1, ylab="No satellites")
cdplot(factor(satellites == 0) ~ color, data = CrabSatellites, ylevels=2:1, , ylab="No satellites")
par(op)

# vcd uses grid graphics, so par(mfrow()) doesn't work
library(vcd)
cd_plot(factor(satellites == 0) ~ weight, data = CrabSatellites, ylab="No satellites")
cd_plot(factor(satellites == 0) ~ color, data = CrabSatellites,  ylab="No satellites")

