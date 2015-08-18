# example from logmult documentation
# Wong, R.S-K. (2001). Multidimensional Association Models : A Multilinear Approach. Sociol. Methods & Research 30, 197-240, Table 2

library(logmult)

  # The table reported in Wong (2010) has a cell inconsistent with
  # what was reported in Wong (2001). To fix this:
# Education and Occupational Attainment Among Women in the United States, 1985-1990
 
data(gss8590, package="logmult")
Women.tab <- margin.table(gss8590[,,c("White Women", "Black Women")], 1:2)
Women.tab[2,4] <- 49
colnames(Women.tab)[5] <- "Farm"

library(vcd)
library(MASS)
mosaic(Women.tab, shade=TRUE)

Women.indep <- loglm(~Education + Occupation, data=Women.tab)
Women.rc1 <- rc(Women.tab, nd=1, weighting="marginal", se="jackknife", verbose=FALSE)
Women.rc2 <- rc(Women.tab, nd=2, weighting="marginal", se="jackknife", verbose=FALSE)

LRstats(Women.indep, Women.rc1, Women.rc2)

Women.rc2
summary(Women.rc2) # Jackknife standard errors are slightly different
               # from their asymptotic counterparts


# what="both" is default
plot(Women.rc2, rev.axes=c(TRUE, FALSE), conf.ellipses=0.68, cex=2)


params <- logmult:::assoc(Women.rc2)
row <- params$row[,,1]
col <- params$col[,,1]
phi <- params$phi
scores <- rbind(row, col)
scores <- sweep(scores, 2, sqrt(abs(phi)), "*")
scores[,1] <- -scores[,1]  # reverse axis 1
lines(scores[1:4,], col="blue", lwd=2)
#lines(scores[4+order(scores[4+(1:5),1]),], col="red", lwd=2)


plot(Women.rc2, rev.axes=c(TRUE, FALSE), conf.ellipses=0.68, cex=2, coords="polar")

  
