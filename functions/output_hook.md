
```r
# knitr hook function to allow an output.lines option e.g., output.lines=12
# prints lines 1:12 ...  output.lines=1:12 does the same output.lines=3:15
# prints lines ... 3:15 ...  output.lines=-(1:8) removes lines 1:8 and
# prints ... 9:n ...  No allowance for anything but a consecutive range of
# lines

library(knitr)
hook_output <- knit_hooks$get("output")
knit_hooks$set(output = function(x, options) {
    lines <- options$output.lines
    if (is.null(lines)) {
        return(hook_output(x, options))  # pass to default hook
    }
    x <- unlist(strsplit(x, "\n"))
    more <- "..."
    if (length(lines) == 1) {
        # first n lines
        if (length(x) > lines) {
            # truncate the output, but add ....
            x <- c(head(x, lines), more)
        }
    } else {
        x <- c(if (abs(lines[1]) > 1) more else NULL, x[lines], if (length(x) > 
            lines[abs(length(lines))]) more else NULL)
    }
    # paste these lines together
    x <- paste(c(x, ""), collapse = "\n")
    hook_output(x, options)
})
```


Normal output.


```r
summary(lm(Sepal.Length ~ Species, data = iris))
```

```
## 
## Call:
## lm(formula = Sepal.Length ~ Species, data = iris)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -1.688 -0.329 -0.006  0.312  1.312 
## 
## Coefficients:
##                   Estimate Std. Error t value Pr(>|t|)    
## (Intercept)         5.0060     0.0728   68.76  < 2e-16 ***
## Speciesversicolor   0.9300     0.1030    9.03  8.8e-16 ***
## Speciesvirginica    1.5820     0.1030   15.37  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.515 on 147 degrees of freedom
## Multiple R-squared:  0.619,	Adjusted R-squared:  0.614 
## F-statistic:  119 on 2 and 147 DF,  p-value: <2e-16
```


The first 4 lines, `output.lines=4`.


```r
summary(lm(Sepal.Length ~ Species, data = iris))
```

```
## 
## Call:
## lm(formula = Sepal.Length ~ Species, data = iris)
## 
...
```


Lines 1:4, `output.lines=1:4`.

```r
summary(lm(Sepal.Length ~ Species, data = iris))
```

```
## 
## Call:
## lm(formula = Sepal.Length ~ Species, data = iris)
## 
...
```



Remove the first 8 lines, `output.lines=-(1:8)`.  This shouldn't print `...` at the beginning.


```r
summary(lm(Sepal.Length ~ Species, data = iris))
```

```
## Coefficients:
##                   Estimate Std. Error t value Pr(>|t|)    
## (Intercept)         5.0060     0.0728   68.76  < 2e-16 ***
## Speciesversicolor   0.9300     0.1030    9.03  8.8e-16 ***
## Speciesvirginica    1.5820     0.1030   15.37  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.515 on 147 degrees of freedom
## Multiple R-squared:  0.619,	Adjusted R-squared:  0.614 
## F-statistic:  119 on 2 and 147 DF,  p-value: <2e-16
...
```


From 8 to 15.


```r
summary(lm(Sepal.Length ~ Species, data = iris))
```

```
...
## 
## Coefficients:
##                   Estimate Std. Error t value Pr(>|t|)    
## (Intercept)         5.0060     0.0728   68.76  < 2e-16 ***
## Speciesversicolor   0.9300     0.1030    9.03  8.8e-16 ***
## Speciesvirginica    1.5820     0.1030   15.37  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
...
```

