# original code
haireye <- margin.table(HairEyeColor, 1:2)

haireye.df <- as.data.frame(haireye)
dummy.hair <-  0+outer(haireye.df$Hair, levels(haireye.df$Hair), `==`)
colnames(dummy.hair)  <- paste0('h', 1:4)
dummy.eye <-  0+outer(haireye.df$Eye, levels(haireye.df$Eye), `==`)
colnames(dummy.eye)  <- paste0('e', 1:4)

haireye.df <- data.frame(haireye.df, dummy.hair, dummy.eye)
haireye.df

Z <- expand.dft(haireye.df)[,-(1:2)]
vnames <- c(levels(haireye.df$Hair), levels(haireye.df$Eye))
colnames(Z) <- vnames
dim(Z)


haireye <- margin.table(HairEyeColor, 1:2)

# Jeff Newmiller, solution 2, corrected

haireye.df <- as.data.frame(haireye)
dummykeys <- data.frame( h = factor( as.integer( haireye.df$Hair ) )
                       , e = factor( as.integer( haireye.df$Eye ) ) )
dummy.hair <- as.data.frame( model.matrix( ~ h - 1, data=dummykeys ))
dummy.eye <- as.data.frame( model.matrix( ~ e - 1, data=dummykeys ))
haireye.df <- data.frame( haireye.df, dummy.hair, dummy.eye )


# Rich Heiberger, removing intercept, including haireye data

haireye.df <- cbind(
    as.data.frame(haireye),
    model.matrix(Freq ~ Hair + Eye, data=haireye,
        contrasts.arg=list(Hair=diag(4), Eye=diag(4)))[,-1]
    )
haireye.df

colnames(haireye.df)[4:11] <- gsub("[a-z]+","", colnames(haireye.df)[4:11])

