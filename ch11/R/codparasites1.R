## load data
library(countreg)
data("CodParasites", package = "countreg")
str(CodParasites)
summary(CodParasites[, c(1:4,7)])

library(gpairs)
gpairs(CodParasites[, c(1:4,7)],
	diag.pars=list(fontsize=16),
	mosaic.pars=list(gp=shading_Friendly)
	)
	

## Table 1 from Hemmingsen et al. (2005)
## number of observations
xtabs(~ area + year, data = CodParasites)
## prevalence of parasites (NAs counted as "yes")
cp.tab <- xtabs(~ area + year + factor(is.na(prevalence) | prevalence == "yes"),
  data = CodParasites)
dimnames(cp.tab)[3] <- list(c("No", "Yes"))
names(dimnames(cp.tab))[3] <- "prevalence"

library(vcd)

#mosaic(~year + area + prevalence, data=cp.tab, shade=TRUE)

mosaic(~year + area + prevalence, data=cp.tab, shade=TRUE, expected=~year:area + prevalence)


doubledecker(prevalence ~ area + year, data=cp.tab)
 
mosaic(~area + year + prevalence, data=cp.tab, 
	split_vertical=c(TRUE, TRUE, FALSE),
	labeling=labeling_doubledecker, spacing=spacing_highlighting,
	expected = ~year:area + prevalence)
	


round(100 * prop.table(cp.tab, 1:2)[,,2], digits = 1)

## omit NAs in response
CodParasites <- subset(CodParasites, !is.na(intensity))



#CodParasites$zero <- factor(CodParasites$intensity == 0)

## exploratory displays for hurdle and counts
op <- par(mfrow = c(2, 2))
plot(prevalence ~ interaction(year, area), data = CodParasites, ylevels=2:1)
plot(prevalence ~ length, data = CodParasites, breaks = c(15, 3:8 * 10, 105), ylevels=2:1)

plot(jitter(intensity) ~ interaction(year, area), data = CodParasites,
  subset = intensity > 0, log = "y")
plot(jitter(intensity) ~ length, data = CodParasites, subset = intensity > 0, log = "y")
CPpos <- subset(CodParasites, intensity>0 & !is.na(length))
with(CPpos, lines(lowess(length, log(intensity)), col="red", lwd=2) )
par(op)

# base graphics plot, log scale + smooth + abline
plot(jitter(intensity) ~ length, data = CPpos, log = "y")
with(CPpos, lines(lowess(length, exp(log(intensity))), col="red", lwd=2) )
lines( CPpos$length, exp( lm(log(intensity) ~ length, data=CPpos)$fitted)   )

# first plot, as a doubledecker -- but vcd::rootogram clashes with countreg::rootogram
library(vcd)
 vcd::doubledecker(prevalence ~ year+area, data=CodParasites)
  
# labeling=labeling_doubledecker(dep_varname="Intensity\n==0"))

# try ggplot2 -- these don't give anything useful.
library(ggplot2)
ggplot(CodParasites, aes(x=area, fill=prevalence, color=year)) + geom_bar() + facet_grid(.~ year)
ggplot(CodParasites, aes(x=length, fill=prevalence)) + geom_bar()

ggplot(CodParasites, aes(x=length, y=as.numeric(prevalence)-1)) +
	geom_jitter(position=position_jitter(height=.05), alpha=0.25) + 
	geom_rug(position='jitter', sides='b') +
#	stat_smooth(method="gam", color="red", fill="red", size=2) +
	stat_smooth(method="loess", color="red", fill="red", size=1.5) + theme_bw() +
	labs(y='prevalence')



## plot only positive values of intensity
CPpos <- subset(CodParasites, intensity>0)

# facet by year
ggplot(CPpos, aes(x=area, y=intensity)) +
	geom_boxplot(outlier.size=3, notch=TRUE, aes(fill=area), alpha=0.2) + 
	geom_jitter(position=position_jitter(width=0.1), alpha=0.25) +
	facet_grid(.~year) + scale_y_log10(breaks=c(1,2,5,10,20,50,100, 200)) +
	theme_bw() + theme(legend.position="none") +
	labs(y='intensity (log scale)')

# facet by area
ggplot(CPpos, aes(x=year, y=intensity)) +
	geom_boxplot(outlier.size=3, notch=TRUE, aes(fill=year), alpha=0.2) + 
	geom_jitter(position=position_jitter(width=0.1), alpha=0.25) +
	facet_grid(.~area) + scale_y_log10(breaks=c(1,2,5,10,20,50,100, 200)) +
	theme_bw() + theme(legend.position="none") +
	labs(y='intensity (log scale)')

ggplot(CPpos, aes(x=length, y=intensity)) +
	geom_jitter(position=position_jitter(height=.1), alpha=0.25) + 
	geom_rug(position='jitter', sides='b') +
	scale_y_log10(breaks=c(1,2,5,10,20,50,100, 200)) +
	stat_smooth(method="loess", color="red", fill="red", size=2) +
	stat_smooth(method="lm", size=1.5) + theme_bw() +
	labs(y='intensity (log scale)')


## count data models
library(MASS); library(countreg)
cp_p   <-    glm(intensity ~ length + area * year, data = CodParasites, family = poisson)
cp_nb  <- glm.nb(intensity ~ length + area * year, data = CodParasites)
cp_hp  <- hurdle(intensity ~ length + area * year, data = CodParasites, dist = "poisson")
cp_hnb <- hurdle(intensity ~ length + area * year, data = CodParasites, dist = "negbin")
cp_zip <- zeroinfl(intensity ~ length + area * year, data = CodParasites, dist = "poisson")
cp_znb <- zeroinfl(intensity ~ length + area * year, data = CodParasites, dist = "negbin")

AIC(cp_p, cp_nb, cp_hp, cp_hnb, cp_zip, cp_znb)
BIC(cp_p, cp_nb, cp_hp, cp_hnb, cp_zip, cp_znb)
#vcdExtra::LRstats(cp_p, cp_nb, cp_hp, cp_hnb, cp_zip, cp_znb)
LRstats(cp_p, cp_nb, cp_hp, cp_hnb, cp_zip, cp_znb, sortby="BIC")

# compare nested pairs
anova(cp_p, cp_nb)
#anova(cp_hp, cp_hnb) - no anova method for hurdle

## rootograms
op <- par(mfrow = c(3, 2), mar=c(4,4,3,1)+.1)
countreg::rootogram(cp_p, max = 50, main = "Poisson")
countreg::rootogram(cp_nb, max = 50, main = "Negative Binomial")
countreg::rootogram(cp_hp, max = 50, main = "Hurdle Poisson")
countreg::rootogram(cp_hnb, max = 50, main = "Hurdle Negative Binomial")
countreg::rootogram(cp_zip, max = 50, main = "Zero-inflated Poisson")
countreg::rootogram(cp_znb, max = 50, main = "Zero-inflated Negative Binomial")
par(op)

# explore the coefs
summary(cp_hnb)

coef(cp_hp, model='zero')
coef(cp_hp, model='count')

# hurdletest -- uses linearHypothesis
cp_hnb1 <- hurdle(intensity ~ length + area * year, data = CodParasites, dist = "negbin", zero="negbin")
hurdletest(cp_hnb1)


library(lmtest)
lrtest(cp_p, cp_nb)
lrtest(cp_hp, cp_hnb)
lrtest(cp_zip, cp_znb)
#lrtest(cp_hp, cp_zip) -- different class


# compare non-nested models
library(pscl)
#vuong(cp_hp, cp_hnb)  # nested
#vuong(cp_zip, cp_znb) # nested
vuong(cp_nb, cp_hnb)   # standard NB vs hurdle NB
#vuong(cp_hp, cp_zip)  # hurdle poisson vs zip
vuong(cp_hnb, cp_znb) # hurdle nb vs znb

summary(cp_hnb)


# do we need length for the count part?

cp_hnb1 <- hurdle(intensity ~ length + area * year | area*year, 
	data = CodParasites, dist = "negbin")

lrtest(cp_hnb, cp_hnb1) 

vuong(cp_hnb, cp_hnb1) 
