# test using coord_trans for logistic regression models

#install.packages("vcdExtra")
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

logit <- function(x) log(x/(1-x))

# generalized logit aka empirical logit
glogit <- function(x, eps=0.001) {
	x <- ifelse(x==0, eps, ifelse(x==1, 1-eps, x)) 
	log(x/(1-x))
	}

# another version, using a min/max value for 0/1 args
glogit <- function(x, zero=-2.5) {
	ifelse(x==0, zero, ifelse(x==1, -zero, log(x/(1-x)))) 
	}


p <- ggplot(Titanicp, aes(age, as.numeric(survived)-1, color=sex)) +
  stat_smooth(method="glm", family=binomial, formula=y~x, 
              alpha=0.2, size=2, aes(fill=sex)) +
  coord_trans(y="logit") + 
  scale_y_continuous(breaks=c(.10, .25, .50, .75, .90)) +
  xlab("Age") + ylab("Pr (survived)")
p

p +  geom_point(position=position_jitter(height=0.02, width=0), size=1.5) 



