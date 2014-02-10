data(Titanic)

titanic.df <- as.data.frame(Titanic)
titanic.df <- expand.dft(titanic.df)
titanic.mca <- mjca(titanic.df)
titanic.mca

res <- plot(titanic.mca)

coords <- res$cols


# rownames of the coords, and the point labels needlessly
# combine factor names and level values, making it difficult
# to work with these for more flexible plots than those
# built in.





