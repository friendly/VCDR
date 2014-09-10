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
t(apply(tox.tab, MARGIN=1:2, FUN=sum))

###################################################

#LOR <-loddsratio(aperm(tox.tab))
#LOR
##confint(LOR)
#
## plotting LOR
#
#LOR.a <- t(as.array(LOR))
#matplot(LOR.a, type="b", 
#  cex=1.5, pch=15:17, cex.lab=1.5, lwd=2, lty=1,
#	ylab='log odds ratio: Urea | Hypertension',
#	xlab='Social class of mother',
#	xlim=c(1,5.5),
#	col=c("blue", "black", "red")
#)
#abline(h=0, col='gray')
#text(5.2, LOR.a[5,]+c(-.05,.05, 0), labels=colnames(LOR.a), cex=1.25)
#text(5.2, max(LOR.a[5,])+.2, "Smoking", cex=1.4)

# using oddsratio
LOR <-oddsratio(aperm(tox.tab))
LOR

matplot(t(LOR), type="b", 
  cex=1.5, pch=15:17, cex.lab=1.5, lwd=2, lty=1,
	ylab='log odds ratio: Urea | Hypertension',
	xlab='Social class of mother',
	xlim=c(1,5.5),
	col=c("blue", "black", "red")
)
abline(h=0, col='gray')
text(5.2, LOR[,5]+c(-.05,.05, 0), labels=rownames(LOR), cex=1.25)
text(5.2, max(LOR[,5])+.2, "Smoking", cex=1.4)

###########################################################
# empirical logits

toxaemia <- t(matrix(aperm(tox.tab), 4, 15))
colnames(toxaemia) <- c("hu", "hU", "uH", "UH")
rowlabs <- expand.grid(smoke=c("0", "1-19", "20+"), class=1:5)
toxaemia <- cbind(toxaemia, rowlabs)

tox.logits <- cbind(blogits(toxaemia[,4:1], add=0.5), rowlabs)

library(ggplot2)
ggplot(tox.logits, aes(x=class, y=logit1, color=smoke)) + 
  theme_bw() +
  geom_point(size=3) + geom_line(size=1.2) +
  ylab("log odds (Hypertension") +
  xlab("Social class of mother") +
  theme(axis.title=element_text(size=16)) +
  scale_color_manual(values=c("blue", "black", "red"))
  
ggplot(tox.logits, aes(x=class, y=logit2, color=smoke)) + 
  theme_bw() +
  geom_point(size=3) + geom_line(size=1.2) +
  ylab("log odds (Urea") +
  xlab("Social class of mother") +
  theme(axis.title=element_text(size=16))+
  scale_color_manual(values=c("blue", "black", "red"))
  

