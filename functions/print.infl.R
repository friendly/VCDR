print.infl <- 
function (x, digits = max(3L, getOption("digits") - 4L), infl.only=FALSE, stars=1, ...) 
{
    cat("Influence measures of\n\t", deparse(x$call), ":\n\n")
    any.star <- apply(x$is.inf, 1L, any, na.rm = TRUE)
    star <- ifelse(x$is.inf, "*", " ")
    star <- apply(star, 1, function(x) paste0(x, collapse=""))
    inf <- if(stars==0) NULL
           else if(stars==1) ifelse(any.star, "*", " ")
           else star
    result <- data.frame(x$infmat, inf)
    if (infl.only) result <- result[any.star,]
    print(result, 
        digits = digits, ...)
    invisible(x)
}


## show actual positions of stars
#stars <- ifelse(isinf, "*", " ")
#apply(stars, 1, function(x) paste0(x, collapse=""))
