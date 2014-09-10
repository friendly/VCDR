GLMs for binary outcomes
========================================================

Example: Passengers on the Titanic

----------------------------------




Data on 1309 passengers on the Titanic is recorded
in the data.frame `ptitanic`.  We fit a logistic regression model
for `survived` using a generalized linear model,
with passenger class (`pclass`), `age`, and `sex` as predictors.


Other analyses have shown that there is at least an interaction
between passenger class and sex, so that term is included in
the basic model.  As in model formulas, `pclass*sex` is
a short-hand for `pclass + sex + pclass:sex`, including the
main effects as well.


```r
titanic.glm = glm(survived ~ pclass * sex + age, family = binomial(logit), data = ptitanic)
summary(titanic.glm)
```

```
## 
## Call:
## glm(formula = survived ~ pclass * sex + age, family = binomial(logit), 
##     data = ptitanic)
## 
## Deviance Residuals: 
##    Min      1Q  Median      3Q     Max  
## -3.078  -0.660  -0.494   0.426   2.494  
## 
## Coefficients:
##                   Estimate Std. Error z value Pr(>|z|)    
## (Intercept)        4.80435    0.54694    8.78  < 2e-16 ***
## pclass2nd         -1.52987    0.56648   -2.70   0.0069 ** 
## pclass3rd         -4.06497    0.51066   -7.96  1.7e-15 ***
## sexmale           -3.88639    0.49238   -7.89  2.9e-15 ***
## age               -0.03840    0.00674   -5.70  1.2e-08 ***
## pclass2nd:sexmale -0.07040    0.63098   -0.11   0.9112    
## pclass3rd:sexmale  2.48881    0.54004    4.61  4.1e-06 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 1414.62  on 1045  degrees of freedom
## Residual deviance:  931.99  on 1039  degrees of freedom
##   (263 observations deleted due to missingness)
## AIC: 946
## 
## Number of Fisher Scoring iterations: 5
```


We can plot the high-order terms in this model using the effects package:


```r
# effect plots
library(effects)
```

```
## Loading required package: lattice Loading required package: grid Loading
## required package: colorspace
## 
## Attaching package: 'effects'
## 
## The following object is masked from 'package:datasets':
## 
## Titanic
```

```r
titanic.eff <- allEffects(titanic.glm)
# All high-order effects
plot(titanic.eff)
```

![plot of chunk titanic-effplot1](figure/titanic-effplot1.png) 


