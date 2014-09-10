  #####################################
  ## Negative binomial distributions ##
  #####################################

  nbplot <- function(p = 0.2, size = 2, ylim = c(0, 0.2))
  {
    plot(0:20, dnbinom(0:20, p = p, size = size), type = "h", col = grey(0.7),
         xlab = "Number of failures (k)", ylab = "Density", ylim = ylim,
         yaxs = "i", bty = "L", lwd=2, cex.lab=1.2)
    nb.mean <- size * (1-p)/p
    nb.sd <- sqrt(nb.mean/p)
    abline(v = nb.mean, col = 2, lwd=2)
    lines(nb.mean + c(-nb.sd, nb.sd), c(0.01, 0.01), col = 2, lwd=2)
    legend(15, 0.2, c(paste("p = ", p), paste("n = ", size)), bty = "n", cex=1.2)
  }
  par(mfrow = c(3,2))
  nbplot()
  nbplot(size = 4)
  nbplot(p = 0.3)
  nbplot(p = 0.3, size = 4)
  nbplot(p = 0.4, size = 2)
  nbplot(p = 0.4, size = 4)
  par(mfrow = c(1,1))
  mtext("Negative binomial distributions for the number of trials to observe n = 2 or n = 4 successes", line = 3)
