#' ---
#' title: "Toxaemia data: mosaic plots"
#' author: "Michael Friendly"
#' date: "10 Mar 2015"
#' ---

data("Toxaemia", package="vcdExtra")

tox.tab <- xtabs(Freq~class+smoke+hyper+urea,Toxaemia)
ftable(tox.tab, row.vars=1)


# symptoms by smoking
#mosaic(xtabs(Freq~smoke+hyper+urea,Toxaemia), shade=TRUE)
mosaic(~smoke+hyper+urea, data=tox.tab, shade=TRUE)

# symptoms by social class
#mosaic(xtabs(Freq~class+hyper+urea,Toxaemia), shade=TRUE)
mosaic(~class+hyper+urea, data=tox.tab, shade=TRUE)

data("Toxaemia", package="vcdExtra")
tox.tab <- xtabs(Freq~class + smoke + hyper + urea, Toxaemia)

ftable(tox.tab, row.vars=1)


# predictors
mosaic(~smoke+class, data=tox.tab, shade=TRUE)

mosaic(~smoke+class, data=tox.tab, shade=TRUE, main="Predictors", legend=FALSE)
 

# responses
mosaic(~hyper+urea, data=tox.tab, shade=TRUE, main="Responses", legend=FALSE)



# as conditional plots
cotabplot(~hyper + urea | smoke, tox.tab, shade=TRUE, legend=FALSE, layout=c(1,3))



#cotabplot(~hyper + urea | class, tox.tab, shade=TRUE, legend=FALSE)
cotabplot(~hyper + urea | class, tox.tab, shade=TRUE, legend=FALSE, layout=c(1,5))


cotabplot(~hyper + urea | smoke, tox.tab, shade=TRUE, legend=FALSE)

# fourfold display
fourfold(aperm(tox.tab), fontsize=16)

# frequencies of class and smoke
#t(apply(tox.tab, MARGIN=1:2, FUN=sum))

margin.table(tox.tab, 2:1)


