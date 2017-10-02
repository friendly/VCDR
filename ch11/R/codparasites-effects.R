#' ---
#' title: Effect plots for hurdle and zero-inflated models
#' author: Michael Friendly
#' ---

#' These examples explore fitting and visualizing hurdle models and zero-inflated models for count data.
#' We use the data on `CodParasites` from the `countreg` package. See DDAR Section 11.5.1
#' 

#+ echo=FALSE
knitr::opts_chunk$set(tidy=FALSE)
knitr::opts_chunk$set(message=FALSE, warning=FALSE)

 
#' ## load required packages
library(countreg)
library(MASS)
library(effects)
library(ggplot2)


#' ## load the data
data("CodParasites", package = "countreg")
## omit NAs in response
CodParasites <- subset(CodParasites, !is.na(intensity))
str(CodParasites)

#' `intensity`` is the count response, the number of paracites; `prevalence` is a factor indicating `intensity > 0`

#' ## Fit some count data models: 
#' We fit all combinations of 2 (Poisson, negbin) x 3 (GLM, hurdle, zeroinfl)
cp_p   <-    glm(intensity ~ length + area * year, data = CodParasites, family = poisson)
cp_nb  <- glm.nb(intensity ~ length + area * year, data = CodParasites)
cp_hp  <- hurdle(intensity ~ length + area * year, data = CodParasites, dist = "poisson")
cp_hnb <- hurdle(intensity ~ length + area * year, data = CodParasites, dist = "negbin")
cp_zip <- zeroinfl(intensity ~ length + area * year, data = CodParasites, dist = "poisson")
cp_znb <- zeroinfl(intensity ~ length + area * year, data = CodParasites, dist = "negbin")


#' ## effect displays
#'
#' These work as usual for standard GLM distributions (any family), and for `MASS::glm.nb``

 
plot(allEffects(cp_p))
plot(allEffects(cp_nb))

# plot on intensity scale
eff.nb <- allEffects(cp_nb)

plot(eff.nb[1], type = "response", 
	main="NB model: length effect")


plot(eff.nb[2], type = "response", multiline=TRUE, ci.style='bars',
	key.args=list(x=.05, y=.95),
	colors=c("black", "red", "blue") ,
	symbols=15:17, cex=2,
	main="NB model: area*year effect")

# plot on intensity scale, but with same ylim
eff.nb <- allEffects(cp_nb)
plot(eff.nb[1], type = "response", ylim=c(0,30),
	main="NB model: length effect")

plot(eff.nb[2], type = "response", ylim=c(0,30),
	multiline=TRUE, ci.style='bars',
	key.args=list(x=.05, y=.95),
	colors=c("black", "red", "blue") ,
	symbols=15:17, cex=2,
	main="NB model: area*year effect")



#' ## Hurdle models
#' 
#' `effect()` cannot handle a hurdle model directly.  However, one can plot effects for the two sub-models
#' fitted separately.

cp_zero  <- glm(prevalence ~ length + area * year, data = CodParasites, family=binomial)
cp_nzero <- glm.nb(intensity ~ length + area * year, data = CodParasites, subset=intensity>0)

# summary(cp_zero)
# summary(cp_nzero)

#' ### Model for the zero counts
#+ fig.width=7
eff.zero <- allEffects(cp_zero)
plot(eff.zero, multiline=TRUE)

plot(eff.zero[1], ylim=c(-2.5, 2.5),
     main="Hurdle zero model: length effect")


plot(eff.zero[2],  ylim=c(-2.5, 2.5),
     multiline=TRUE,
     key.args=list(x=.05, y=.95),
     colors=c("black", "red", "blue") ,
     symbols=15:17, cex=2,
     main="Hurdle zero model: area*year effect")

#' ### Model for the non-zero counts

eff.nzero <- allEffects(cp_nzero)
plot(eff.nzero, multiline=TRUE)



#' ## Full model plots
#'  
#' Get the predicted values for count and zero components.
#' Plot these with `ggplot2`.
#' 
#' Unfortunately, the `predict` methods don't provide standard errors.
#' Could get these by bootstrapping...

# home-brew, full model plot: plot the entire response surface
newdata <- expand.grid( length=seq(20, 100, 10), 
                        area=levels(CodParasites$area), 
                        year=levels(CodParasites$year))
 
pred_func <- function(model, newdata) {
	data.frame(
		newdata,
		intensity = predict(model, newdata=newdata, type="count"),
		zeros = predict(model, newdata=newdata, type="zero"))
}

pred <- pred_func(cp_hp, newdata)

#' Plotting with ggplot2
	

#' plot intensity
ggplot(pred, aes(x=length, y=intensity, color=area)) + geom_line(size=2) + 
  facet_wrap(~year) + scale_y_log10(breaks=c(1,2,5,10,20))

#' plot the zeros
ggplot(pred, aes(x=length, y=zeros, color=area)) + geom_line(size=2) + 
  facet_wrap(~year)

#' Sort of an effect plot: Plot area * year effect, at mean length
newdata <- expand.grid( length=mean(CodParasites$length, na.rm=TRUE), 
                        area=levels(CodParasites$area), 
                        year=levels(CodParasites$year))
pred <- pred_func(cp_hp, newdata)

# (perhaps should plot on log scale)
ggplot(pred, aes(x=area, y=intensity, group=year, color=year)) + 
  geom_point(size=3) + geom_line(size=1.25) + 
  scale_y_log10(breaks=c(1,2,5,10,20))
ggplot(pred, aes(x=area, y=zeros, group=year, color=year)) + 
  geom_point(size=3) + 
  geom_line(size=1.25)
 

#' Try this using hurdle model
newdata <- expand.grid( length=mean(CodParasites$length, na.rm=TRUE), 
                        area=levels(CodParasites$area), 
                        year=levels(CodParasites$year))
pred <- pred_func(cp_hnb, newdata)

ggplot(pred, aes(x=area, y=intensity, group=year, color=year)) + 
  geom_point(size=3) + geom_line(size=1.25) + 
  scale_y_log10(breaks=c(1,2,5,10,20))

#' why does the count model give predicted values
#' outside 0-1?

ggplot(pred, aes(x=area, y=zeros, group=year, color=year)) + 
  geom_point(size=3) + 
  geom_line(size=1.25)




