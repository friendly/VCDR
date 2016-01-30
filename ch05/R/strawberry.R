# Exercise in chapter 5
# from help("jansen.strawberry", package="agridat")

data("jansen.strawberry", package="agridat")

dat <- jansen.strawberry
dat <- transform(dat, category=ordered(category, levels=c('C1','C2','C3')))
levels(dat$male) <- paste0("M", 1:3)
levels(dat$female) <- paste0("F", 1:4) 

jansen.tab <- xtabs(count~male + female + category, data=dat)
names(dimnames(jansen.tab)) <- c("Male parent", "Female parent", "Disease category")
ftable(jansen.tab)


mosaicplot(jansen.tab,
#           color=c("lemonchiffon1","moccasin","lightsalmon1","indianred"),
           color=c("moccasin","lightsalmon1","indianred"),
           main="jansen.strawberry disease ratings",
           xlab="Male parent", ylab="Female parent")

library(vcd)
pairs(jansen.tab, shade=TRUE)

# similar to mosaicplot()
cols <- c("moccasin","lightsalmon1","indianred")
fill <- array(rep(cols,each=12), dim=dim(jansen.tab))
mosaic(jansen.tab, gp=gpar(fill=fill))

#mosaic(jansen.tab, highlighting=3)
mosaic(jansen.tab, highlighting=3, highlighting_fill=cols)

# baseline model
loglm(~1*2+3,data=jansen.tab)
mosaic(jansen.tab, expected = ~ 1*2+3)


