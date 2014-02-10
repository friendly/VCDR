install.packages("vcdExtra")
data(Titanicp, package="vcdExtra")
str(Titanicp)

require(ggplot2)
# remove missings on age
Titanicp <- Titanicp[!is.na(Titanicp$age),]

ggplot(Titanicp, aes(age, as.numeric(survived)-1, color=sex)) +
  stat_smooth(method="glm", family=binomial, formula=y~x, alpha=0.2, size=2, aes(fill=sex)) +
  geom_point(position=position_jitter(height=0.02, width=0), size=1.5) 

mod <- glm(survived ~ age*sex, family=binomial, data=Titanicp)
summary(mod)

logit <- function(x) log(x)/log(1-x)
ggplot(Titanicp, aes(age, as.numeric(survived)-1, color=sex)) +
  stat_smooth(method="glm", family=binomial, formula=y~x, 
              alpha=0.2, size=2, aes(fill=sex)) +
#  geom_point(position=position_jitter(height=0.02, width=0), size=1.5) +
  coord_trans(y="logit") + 
  scale_y_continuous(breaks=c(.10, .25, .50, .75, .90)) +
  xlab("Age") + ylab("Pr (survived)")


