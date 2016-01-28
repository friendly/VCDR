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

# quick check on important effects
bwt.mod0 <- glm(low ~ age + lwt + race + smoke + ptd + ht + ui + ftv, data=birthwt, family = binomial)
summary(bwt.mod0)

library(gpairs)
vars <- c("low", "age", "lwt", "race", "ptd")
gpairs(birthwt[,vars],
  diag.pars=list(fontsize=16, hist.color="lightgray"),
  mosaic.pars=list(gp=shading_Friendly,
                   gp_args=list(interpolate=1:4)))

library(ggplot2)
ggplot(birthwt, aes(x=lwt, y=low)) +
	


