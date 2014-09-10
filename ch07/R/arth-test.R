# test using coord_trans
#library(vcdExtra)

data(Arthritis, package="vcd")
Arthritis$Better <- as.numeric(Arthritis$Improved > "None")
arth.logistic <- glm(Better ~ Age, data=Arthritis, family=binomial)

# get fitted values on the logit scale
pred <- data.frame(Arthritis,
                   predict(arth.logistic, se.fit=TRUE))

head(pred)

library(ggplot2)
library(scales)

# plot on logit scale
gg <- ggplot(pred, aes(x=Age, y=fit)) +               
  geom_line(size = 2) + theme_bw() +
  geom_ribbon(aes(ymin = fit - 1.96 * se.fit,
                  ymax = fit + 1.96 * se.fit,), alpha = 0.2,
              color = "transparent") +
  labs(x = "Age", y = "Log odds (Better)") 
gg

gg + coord_trans(ytrans="logis")

gg + coord_trans(ytrans=probability_trans("logis"))


# doing it manually
pred2 <- within(pred, {
             prob  <- plogis(fit)
             lower <- plogis(fit - 1.96 * se.fit)
             upper <- plogis(fit + 1.96 * se.fit)
             })


gg2 <- ggplot(pred2, aes(x=Age, y=prob)) +               
  geom_line(size = 2) + theme_bw() +
  geom_ribbon(aes(ymin = lower,
                  ymax = upper), alpha = 0.2,
              color = "transparent") +
  labs(x = "Age", y = "Probability (Better)") 
gg2

ggplot(pred, aes(x = Age, y = Better)) + geom_smooth(method = "glm", family = binomial)


plogis_trans <- function () {
	probability_trans("logis")
}


