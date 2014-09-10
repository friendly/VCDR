library(vcd)

data(Arthritis, package="vcd")
Arthritis$Better <- as.numeric(Arthritis$Improved > "None")
arth.logistic <- glm(Better ~ Age, data=Arthritis, family=binomial)

beta <- coef(arth.logistic)
se <- sqrt(diag(vcov(arth.logistic)))

n=50
mult <- 2
# grid of b0, b1 values
grid <- expand.grid(b0 = seq(beta[1]-mult*se[1], beta[1]+mult*se[1], length=n),
                    b1 = seq(beta[2]-mult*se[2], beta[2]+mult*se[2], length=n))

logit2p <- function(logit) 1/(1 + exp(-logit))

phat <- function(b0, b1, x) logit2p(b0 + b1*x)
 
loglike <- function(b0, b1, x, y) sum( y*log(phat(b0,b1,x)) 
                                    + (1-y)*log(1-phat(b0,b1,x)) )
	
#LL <- apply(grid, 1, FUN=loglike(b0, b1, Arthritis$Age, Arthritis$Better))

for(i in 1:nrow(grid)) {
	grid$LL[i] <- loglike(grid$b0[i], grid$b1[i], Arthritis$Age, Arthritis$Better)
}

library(lattice)
contourplot(LL ~ b1 + b0, data=grid, cuts=20, region=TRUE)


# using ggplot2

library(ggplot2)


gp <- ggplot(grid, aes(x=b1, y=b0, z=LL)) + theme_bw()

gp + stat_contour(aes(colour = ..level..), size = 2, bins=20) + 
     theme(legend.position = "none") +
     geom_hline(yintercept=beta[1], color="red") +
     geom_vline(xintercept=beta[2], color="red") 
     
