#' ---
#' title: "glm() fits for Saxony data, following Lindsey"
#' author: "Michael Friendly"
#' date: "30 Oct 2015"
#' ---

library(vcdExtra)
data(Saxony, package="vcd")
Males <- as.numeric(names(Saxony))
Families <- as.vector(Saxony)
Sax.df <- data.frame(Males, Families)

# fit binomial (12, p) as a glm
Sax.bin <- glm(Families ~ Males, offset=lchoose(12,0:12), family=poisson, data=Sax.df)

# brief model summaries
LRstats(Sax.bin)
coef(Sax.bin)


#YlogitY <- ifelse(Males %in% c(0,12), 0, -Males * log(Males/(12-Males)))
#
#   if 0 < males < 12
#      then ylogity = -males * log(males/(12-males));
#      else ylogity = 0;


# double binomial, (12, p, psi)
Sax.df$YlogitY <- 
	Males * log(ifelse(Males==0,1,Males)) +
	(12-Males) * log(ifelse(12-Males==0,1,12-Males))

Sax.dbin <- glm(Families ~ Males + YlogitY, offset=lchoose(12,0:12),
	family=poisson, data=Sax.df)
coef(Sax.dbin)

anova(Sax.bin, Sax.dbin, test="Chisq")
LRstats(glmlist(Sax.bin, Sax.dbin))

results <- data.frame(Sax.df,
          fit.bin = fitted(Sax.bin), res.bin = rstandard(Sax.bin),
          fit.dbin = fitted(Sax.dbin), res.dbin = rstandard(Sax.dbin))
print(results, digits = 2)

with(results, vcd::rootogram(Families, fit.dbin, Males,
                        xlab = "Number of males"))
