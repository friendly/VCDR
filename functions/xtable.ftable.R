# convert an ftable/structable object to a data.frame, suitable
# for use with xtable.

# this function from package metrumrg
ftable2data.frame <- 
function (x, ...) 
{
    y <- format(x, quote = FALSE)
    z <- data.frame(y[-1, ], stringsAsFactors = FALSE)
    names(z) <- y[1, ]
    z
}

# methods for ftable & structable objects

xtable.ftable <- function(x, ...) {
  tab <- ftable2data.frame(x)
  xtable(tab, ...)
}

xtable.structable <- function(x, ...) {
  tab <- ftable2data.frame(x)
  xtable(tab, ...)
}


TESTME <- FALSE
if(TESTME) {
Health <- expand.grid(concerns = c("sex", "menstrual", "healthy", "nothing"),
                      age      = c("12-15", "16-17"),
                      gender   = c("M", "F"))
Health$Freq <- c(4, 0, 42, 57, 2, 0, 7, 20,
                 9, 4, 19, 71, 7, 8, 10, 21)

# make a Latex table
health.table <- ftable(gender+age ~ concerns, health.tab)
library(xtable)
xtable(health.table)
print(xtable(health.table), include.rownames=FALSE)

}
