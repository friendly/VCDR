# calculations for Table 4.7

findTableWithOAM <- function(or, tab) {
        m <- rowSums(tab)[1]
        n <- rowSums(tab)[2]
        t <- colSums(tab)[1]
        if (or == 1) 
            x <- t * n/(m + n)
        else if (or == Inf) 
            x <- max(0, t - m)
        else {
            A <- or - 1
            B <- or * (m - t) + (n + t)
            C <- -t * n
            x <- (-B + sqrt(B^2 - 4 * A * C))/(2 * A)
        }
        matrix(c(t - x, x, m - t + x, n - x), nrow = 2)
    }

stdize <- function(tab) {
                u <- sqrt(odds(tab)$or)
                u <- u/(1 + u)
                y <- matrix(c(u, 1 - u, 1 - u, u), nrow = 2)
        y
    }
odds <- function(x) {
        if (length(dim(x)) == 2) {
            dim(x) <- c(dim(x), 1)
            k <- 1
        }
        else k <- dim(x)[3]
        or <- double(k)
        se <- double(k)
        for (i in 1:k) {
            f <- x[, , i]
            if (any(f == 0)) 
                f <- f + 0.5
            or[i] <- (f[1, 1] * f[2, 2])/(f[1, 2] * f[2, 1])
            se[i] <- sqrt(sum(1/f))
        }
        list(or = or, se = se)
    }
   
Berkeley <- margin.table(UCBAdmissions, 1:2)
oddsratio(Berkeley)

OR <- oddsratio(Berkeley, log=FALSE)

confint(oddsratio(Berkeley))
CI <- confint(oddsratio(Berkeley, log=FALSE))

f1 <- findTableWithOAM(CI[1], Berkeley)
f2 <- findTableWithOAM(OR, Berkeley)
f3 <- findTableWithOAM(CI[2], Berkeley)

tab <- rbind(
	cbind(round(stdize(f1),3), round(f1, 1)),
	cbind(round(stdize(f2),3), round(f2, 1)),
	cbind(round(stdize(f3),3), round(f3, 1)))

rownames(tab) <- c("Lower", "limit", "Data", "", "Upper", "limit2")
colnames(tab) <- c("Odds", "Std1", "Std2", "Freq1", "Freq2")
tab

tab <- cbind(c(CI[1],NA,OR,NA,CI[2],NA), tab)
tab

library(xtable)
xtable(tab, digits=c(3, 3, 3,3,1,1))
