\S 6.4, suicide data example

data("Suicide", package="vcd")
library(ca)


# interactive coding of sex and age.group
Suicide <- within(Suicide, {
	age_sex <- paste(age.group, toupper(substr(sex,1,1)))
	})

## using 9 level method
#suicide.tab <- xtabs(Freq ~ age_sex + method, data=Suicide)
#suicide.ca <- ca(suicide.tab)
#summary(suicide.ca)
#plot(suicide.ca)

# using 8 level method2

suicide.tab <- xtabs(Freq ~ age_sex + method2, data=Suicide)
suicide.ca <- ca(suicide.tab)
summary(suicide.ca)

op <- par(cex=1.3, mar=c(4,4,1,1)+.1)
plot(suicide.ca)
par(op)

##################################################################
# mosaic display

suicide.tab3 <- xtabs(Freq ~ sex + age.group + method2, data=Suicide)

# reorder methods by CA scores
suicide.ca$colnames
suicide.ca$colnames[order(suicide.ca$colcoord[,1])]

suicide.tab3 <- suicide.tab3[, , order(suicide.ca$colcoord[,1])]
# delete other
suicide.tab3 <- suicide.tab3[,, -5]
ftable(suicide.tab3)


#mosaic(suicide.tab3, shade=TRUE, expected=~age.group*sex + method2,
#	labeling_args=list(abbreviate_labs=c(FALSE, FALSE, 3)),
#	                   rot_labels = c(0, 0, 0, 90))

mosaic(suicide.tab3, shade=TRUE, legend=FALSE,
       expected=~age.group*sex + method2,
	labeling_args=list(abbreviate_labs=c(FALSE, FALSE, 5)),
	                   rot_labels = c(0, 0, 0, 90))

#####################################################################
# \S 6.4.1 marginal tables

# two way, ignoring sex
suicide.tab2 <- xtabs(Freq ~ age.group + method2, data=Suicide)
suicide.tab2
suicide.ca2 <- ca(suicide.tab2)
plot(suicide.ca2)

# relation of sex and method
suicide.sup <- xtabs(Freq ~ sex + method2, data=Suicide)
suicide.tab2s <- rbind(suicide.tab2, suicide.sup)

suicide.ca2s <- ca(suicide.tab2s, suprow=6:7)
summary(suicide.ca2s)

op <- par(cex=1.3, mar=c(4,4,1,1)+.1)
res <- plot(suicide.ca2s, pch=c(16, 15, 17, 24))
lines(res$rows[6:7,])
par(op)

