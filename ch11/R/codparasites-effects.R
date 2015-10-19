#' ---
#' title: Effect plots for hurdle and zero-inflated models
#' author: Michael Friendly
#' ---

## load data
library(countreg)
data("CodParasites", package = "countreg")
## omit NAs in response
CodParasites <- subset(CodParasites, !is.na(intensity))

#' fit some count data models: 2 (Poisson, negbin) x 3 (GLM, hurdle, zeroinfl)
cp_p   <-    glm(intensity ~ length + area * year, data = CodParasites, family = poisson)
cp_nb  <- glm.nb(intensity ~ length + area * year, data = CodParasites)
cp_hp  <- hurdle(intensity ~ length + area * year, data = CodParasites, dist = "poisson")
cp_hnb <- hurdle(intensity ~ length + area * year, data = CodParasites, dist = "negbin")
cp_zip <- zeroinfl(intensity ~ length + area * year, data = CodParasites, dist = "poisson")
cp_znb <- zeroinfl(intensity ~ length + area * year, data = CodParasites, dist = "negbin")


#' **effect displays**
#'
#' These work for standard GLM distributions

library(effects)
 
plot(allEffects(cp_p))
plot(allEffects(cp_nb))

# plot on intensity scale
eff.nb <- allEffects(cp_nb)
#plot(eff.nb[1], rescale=FALSE, 
#	main="NB model: length effect")
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


# doesn't work, of course for hurdle or zeroinfl models
#eff_hp <- allEffects(cp_hp)

#' **Hurdle models**
#' 
#' Get the predicted values for count and zero components.
#' Plot these either as full-model plots or as effect plots.
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
	
library(ggplot2)

# plot count and zeros separately
ggplot(pred, aes(x=length, y=intensity, color=area)) + geom_line(size=2) + 
  facet_wrap(~year) + scale_y_log10(breaks=c(1,2,5,10,20))

ggplot(pred, aes(x=length, y=zeros, color=area)) + geom_line(size=2) + 
  facet_wrap(~year)

#' **Effect plot**: area * year effect, at mean length
newdata <- expand.grid( length=mean(CodParasites$length, na.rm=TRUE), 
                        area=levels(CodParasites$area), 
                        year=levels(CodParasites$year))
pred <- pred_func(cp_hp, newdata)

# perhaps should plot on log scale
ggplot(pred, aes(x=area, y=intensity, group=year, color=year)) + 
  geom_point(size=3) + geom_line(size=1.25) + 
  scale_y_log10(breaks=c(1,2,5,10,20))
ggplot(pred, aes(x=area, y=zeros, group=year, color=year)) + 
  geom_point(size=3) + 
  geom_line(size=1.25)
 

# try using hurdle model -- why does the count model give predicted values
# outside 0-1?

newdata <- expand.grid( length=mean(CodParasites$length, na.rm=TRUE), 
                        area=levels(CodParasites$area), 
                        year=levels(CodParasites$year))
pred <- pred_func(cp_hnb, newdata)

ggplot(pred, aes(x=area, y=intensity, group=year, color=year)) + 
  geom_point(size=3) + geom_line(size=1.25) + 
  scale_y_log10(breaks=c(1,2,5,10,20))
ggplot(pred, aes(x=area, y=zeros, group=year, color=year)) + 
  geom_point(size=3) + 
  geom_line(size=1.25)

#' Using effects directly on the two submodels, fitted separately

cp_zero  <- glm(prevalence ~ length + area * year, data = CodParasites, family=binomial)
cp_nzero <- glm.nb(intensity ~ length + area * year, data = CodParasites, subset=intensity>0)

summary(cp_zero)
summary(cp_nzero)

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


eff.nzero <- allEffects(cp_nzero)
plot(eff.nzero, multiline=TRUE)



