library(vcd)
library(colorspace)
Arthritis <- transform(Arthritis, Better = Improved > "None")
cols <- rainbow_hcl(3)

## Figure 7.4
arth.logistic <- glm(Better ~ Age, data = Arthritis, family = binomial)
binreg_plot(arth.logistic)

arth.lm <- glm(Better ~ Age, data = Arthritis)
grid_abline(arth.lm, gp = gpar(lwd = 3, col = cols[2]))

arth.loess <- lowess(Arthritis$Age, Arthritis$Better, f = 0.9)
grid.lines(arth.loess$x, arth.loess$y,
           gp = gpar(lwd = 2, col = cols[3]), default.units = "native")


## Figure 7.5
# FIXME -- xlim should be honored in predicted values in binreg_plot: the goal is to show
# prediction for low temperatures.  The ggplot version allows fullrange=TRUE
# that accomplishes this.
# DM: fixed
shuttle.mod <- glm(cbind(nFailures, 6 - nFailures) ~ Temperature,
                   data = SpaceShuttle, na.action = na.exclude, family = binomial)
binreg_plot(shuttle.mod, xlim = c(30, 81), pred_range = "xlim",
            ylab = "O-Ring Failure Probability", xlab = "Temperature (F)")

## Figure 7.6, 7.7
## Conditional plots are out of scope of binreg_plot, designed for
## full-model plots

## Figure 7.8
# -- these plots should show the same slopes in the two subplots
# -- need to have the same xlim and ylim for this to be so
arth.logistic2 <- glm(Better ~ I(Age - 50) + Treatment,
                      data = Arthritis, family = binomial)
binreg_plot(arth.logistic2, type = "link", subset = Sex == "Female",
            main = "Female", xlim = c(25, 75), ylim = c(-2, 2))
binreg_plot(arth.logistic2, type = "link", subset = Sex == "Male",
            main = "Male", xlim = c(25, 75), ylim = c(-2, 2))

## Figure 7.9
# -- make xlim the same
binreg_plot(arth.logistic2, subset = Sex == "Female", main = "Female",
            xlim=c(25, 75))
binreg_plot(arth.logistic2, subset = Sex == "Male", main = "Male",
            xlim=c(25, 75))


## ## Figure 7.15 (as a full-model plot!)

## data("Donner", package="vcdExtra")
## donner1 <- glm(survived ~ age + sex, data = Donner)
## binreg_plot(donner1)

## ## Figure 7.16, left (as a full-model plot!)
## donner2 <- glm(survived ~ poly(age, 2) + sex, data = Donner)
## binreg_plot(donner2)

## Figure 7.23
data("ICU", package="vcdExtra")
levels(ICU$cancer) <- c("NoCancer", "Cancer")
levels(ICU$admit) <- c("Elect","Emerg")
levels(ICU$uncons) <- c("Cons","Uncons")
icu.glm2 <- glm(died ~ age + cancer + admit + uncons,
                data = ICU, family = binomial)
binreg_plot(icu.glm2, type = "link", legend = FALSE, cex = 0,
            labels = TRUE, labels_just = c("right", "bottom"))

