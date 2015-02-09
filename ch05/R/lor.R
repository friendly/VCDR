data(Hoyt, package="vcdExtra")

## Hoyt data
(lor.Hoyt <- loddsratio(Hoyt))
confint(lor.Hoyt)

library(ggplot2)

# How to plot this?
lor.Hoyt.df <- as.data.frame(lor.Hoyt)

ggplot(lor.Hoyt.df, aes(x=Occupation, y=LOR, group=Status, color=Status)) + 
	geom_point() + geom_line() +
	facet_wrap(~Sex + Rank)

???	
Hoyt.mod <- lm(LOR ~ Status + Rank + Occupation * Sex, data=lor.Hoyt.df, weights=1/ASE^2)
anova(Hoyt.mod)

data(VisualAcuity, package="vcd")
vis.tab <- xtabs(Freq ~ left + right + gender, data=VisualAcuity)

lor.vis <- loddsratio(vis.tab)

lor.vis.df <- as.data.frame(lor.vis)
str(lor.vis.df)

lor.vis.a <- as.array(lor.vis)
matplot(lor.vis.a[,,1], type="b", xaxt="n", pch=15:17, cex=1.4, ylim=c(-1,4),
	xlab="Left eye", ylab="log odds ratio Left:Right", main="Men")
axis(side=1, at=1:3, labels=rownames(lor.vis.a[,,1]))
text(1, lor.vis.a[1,,1], colnames(lor.vis.a[,,1]), pos=4, col=1:3)
text(1, max(lor.vis.a[1,,1])+.2, "Right eye", xpd=TRUE)

matplot(lor.vis.a[,,2], type="b", xaxt="n", pch=15:17,  cex=1.4, ylim=c(-1,4),
	xlab="Left eye", ylab="log odds ratio Left:Right", main="Women")
axis(side=1, at=1:3, labels=rownames(lor.vis.a[,,2]))
text(1, lor.vis.a[1,,2], colnames(lor.vis.a[,,2]), pos=4, col=1:3)
text(1, max(lor.vis.a[1,,2])+.2, "Right eye", xpd=TRUE)




## 4 way tables 
data(Punishment, package="vcd")
punish <- xtabs(Freq ~ memory + attitude + age + education, data = Punishment)
mosaic(~ age + education + memory + attitude, data = punish, keep = FALSE,
       gp = gpar(fill = grey.colors(2)), spacing = spacing_highlighting,
       rep = c(attitude = FALSE))

lor.pun <- loddsratio(punish)
lor.pun
confint(lor.pun)
if(require("lmtest")) coeftest(lor.pun)

# visualize the log odds ratios, by education
lor.pun.a <- as.array(lor.pun)
matplot(lor.pun.a, type='b', xaxt='n', pch=15:17, cex=1.5,
	ylab='log odds ratio: Attitude x Memory',
	xlab='Age', xlim=c(0.5, 3), ylim=c(-2, 1), 
	main="Attitudes toward corporal punishment")
abline(h=0, col='gray')
axis(side=1, at=1:3, labels=rownames(lor.pun.a))
text(0.5, lor.pun.a[1,], colnames(lor.pun.a), pos=4, col=1:3)
text(0.6, max(lor.pun.a[1,])+.2, "Education")

# visualize the log odds ratios, by age
matplot(t(lor.pun.a), type='b', xaxt='n', pch=15:17, cex=1.5,
	ylab='log odds ratio: Attitude x Memory',
	xlab='Education', xlim=c(0.5, 3), ylim=c(-2, 1), 
	main="Attitudes toward corporal punishment")
abline(h=0, col='gray')
axis(side=1, at=1:3, labels=colnames(lor.pun.a))
text(0.5, lor.pun.a[,1], rownames(lor.pun.a), pos=4, col=1:3)
text(0.6, max(lor.pun.a[,1])+.2, "Age")

# fit linear model using WLS
lor.pun.df <- as.data.frame(lor.pun)

lor.pun.df <- within(lor.pun.df, {
	age = as.numeric(age)
	education = as.numeric(education)
	})

pun.mod <- lm(LOR ~ age * education, data=lor.pun.df, weights=1/ASE^2)
anova(pun.mod)



