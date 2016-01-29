#' ---
#' title: "birthwt data, Exercise 7.6"
#' author: "Michael Friendly"
#' date: "28 Jan 2016"
#' ---

data("birthwt", package="MASS")
birthwt <- within(birthwt, {
	low <- factor(low)
  race <- factor(race, labels = c("white", "black", "other"))
	ptd <- factor(ptl > 0)  # premature labors
	ftv <- factor(ftv)      # physician visits
	levels(ftv)[-(1:2)] <- "2+"
	smoke <- factor(smoke>0)
	ht <- factor(ht>0)
	ui <- factor(ui>0)
  })


library(gpairs)
vars <- c("low", "age", "lwt", "race", "ptd")
gpairs(birthwt[,vars],
  diag.pars=list(fontsize=16, hist.color="lightgray"),
  lower.pars = list(scatter="lm"),
  upper.pars = list(scatter="lm"),
  mosaic.pars=list(gp=shading_Friendly,
                   gp_args=list(interpolate=1:4)))

library(ggplot2)
gg <- ggplot(birthwt, aes(x=lwt, y=as.numeric(low)-1, color=smoke)) +
	geom_point(position=position_jitter(height=0.05, width=0), size=2) +
	ylim(-.1, 1) + theme_bw() + 
	xlab("Mother's weight") + ylab("Low birth weight")

# use lm smoother
	gg + geom_smooth(method="lm", aes(fill=smoke), alpha=0.3, size=2) 

# use glm smoother
	gg + geom_smooth(method="glm", method.args=list(family = binomial),
	                 aes(fill=smoke), alpha=0.3, size=2) 

# quick check on important effects
bwt.mod0 <- glm(low ~ age + lwt + race + smoke + ptd + ht + ui + ftv, data=birthwt, family = binomial)
summary(bwt.mod0)
car::Anova(bwt.mod0)

# remove NS terms

bwt.mod1 <- update(bwt.mod0, . ~ . - ui - ftv)
Anova(bwt.mod1)
anova(bwt.mod1, bwt.mod0, test="Chisq")

library(effects)
plot(allEffects(bwt.mod1), ci.style="bands")
 



	


