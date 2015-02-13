# exercises plotting lod odds ratios

data(Hoyt, package="vcdExtra")

## Hoyt data
(Hoyt.lor <- loddsratio(Hoyt))
confint(Hoyt.lor)

library(ggplot2)

# How to plot this?
Hoyt.lor.df <- as.data.frame(Hoyt.lor)

ggplot(Hoyt.lor.df, aes(x=Occupation, y=LOR, group=Status, color=Status)) + 
	geom_point() + geom_line() +
	facet_wrap(~Sex + Rank)

???	
Hoyt.mod <- lm(LOR ~ Status + Rank + Occupation * Sex, data=Hoyt.lor.df, weights=1/ASE^2)
anova(Hoyt.mod)

data(VisualAcuity, package="vcd")
vis.tab <- xtabs(Freq ~ left + right + gender, data=VisualAcuity)

vis.lor <- loddsratio(vis.tab)

vis.lor.df <- as.data.frame(vis.lor)
str(vis.lor.df)

vis.lor.a <- as.array(vis.lor)
matplot(vis.lor.a[,,1], type="b", xaxt="n", pch=15:17, cex=1.4, ylim=c(-1,4),
	xlab="Left eye", ylab="log odds ratio Left:Right", main="Men")
axis(side=1, at=1:3, labels=rownames(vis.lor.a[,,1]))
text(1, vis.lor.a[1,,1], colnames(vis.lor.a[,,1]), pos=4, col=1:3)
text(1, max(vis.lor.a[1,,1])+.2, "Right eye", xpd=TRUE)

matplot(vis.lor.a[,,2], type="b", xaxt="n", pch=15:17,  cex=1.4, ylim=c(-1,4),
	xlab="Left eye", ylab="log odds ratio Left:Right", main="Women")
axis(side=1, at=1:3, labels=rownames(vis.lor.a[,,2]))
text(1, vis.lor.a[1,,2], colnames(vis.lor.a[,,2]), pos=4, col=1:3)
text(1, max(vis.lor.a[1,,2])+.2, "Right eye", xpd=TRUE)




## 4 way tables 
data(Punishment, package="vcd")
punish <- xtabs(Freq ~ memory + attitude + age + education, data = Punishment)
mosaic(~ age + education + memory + attitude, data = punish, keep = FALSE,
       gp = gpar(fill = grey.colors(2)), spacing = spacing_highlighting,
       rep = c(attitude = FALSE))

pun.lor <- loddsratio(punish)
pun.lor
confint(pun.lor)
if(require("lmtest")) coeftest(pun.lor)

pun.lor.df <- as.data.frame(pun.lor)
pun.lor.df


# visualize the log odds ratios, by education
pun.lor.a <- as.array(pun.lor)
matplot(pun.lor.a, type='b', xaxt='n', pch=15:17, cex=1.5,
	ylab='log odds ratio: Attitude x Memory',
	xlab='Age', xlim=c(0.5, 3), ylim=c(-2, 1), 
	main="Attitudes toward corporal punishment")
abline(h=0, col='gray')
axis(side=1, at=1:3, labels=rownames(pun.lor.a))
text(0.5, pun.lor.a[1,], colnames(pun.lor.a), pos=4, col=1:3)
text(0.6, max(pun.lor.a[1,])+.2, "Education")

# visualize the log odds ratios, by age
matplot(t(pun.lor.a), type='b', xaxt='n', pch=15:17, cex=1.5,
	ylab='log odds ratio: Attitude x Memory',
	xlab='Education', xlim=c(0.5, 3), ylim=c(-2, 1), 
	main="Attitudes toward corporal punishment")
abline(h=0, col='gray')
axis(side=1, at=1:3, labels=colnames(pun.lor.a))
text(0.5, pun.lor.a[,1], rownames(pun.lor.a), pos=4, col=1:3)
text(0.6, max(pun.lor.a[,1])+.2, "Age")

# fit linear model using WLS
pun.lor.df <- as.data.frame(pun.lor)

pun.lor.df <- within(pun.lor.df, {
	age = as.numeric(age)
	education = as.numeric(education)
	})

pun.mod <- lm(LOR ~ age * education, data=pun.lor.df, weights=1/ASE^2)
anova(pun.mod)

# using ggplot

library(ggplot2)
limits <- aes(ymax = LOR + ASE, ymin=LOR - ASE)
dodge <- position_dodge(width=0.1)

ggplot(pun.lor.df, aes(x=age, y=LOR, group=education, color=education)) + 
	geom_point(size=3) + geom_line(size=1.5) +
	geom_errorbar(limits, position=dodge, width=0.25) +
	labs(y="log odds ratio: Attitude | Memory") +
	theme_bw() + 
	theme(legend.position = c(0.9, 0.8),   # c(0,0) bottom left, c(1,1) top-right
	      legend.background = element_rect(fill = "gray90", colour = "black")) 

# housing data from MASS

data(housing, package="MASS")

mosaic(aperm(housing.tab), shade=TRUE)
mosaic(~Sat+Infl|Type+Cont, housing.tab, shade=TRUE)

housing.tab <- xtabs(Freq ~ Sat + Infl + Type + Cont, data=housing)
housing.lor <- loddsratio(housing.tab)
housing.lor.df <- as.data.frame(housing.lor)

library(ggplot2)
limits <- aes(ymax = LOR + ASE, ymin=LOR - ASE)
dodge <- position_dodge(width=0.1)
ggplot(housing.lor.df, aes(x=Sat, y=LOR, group=Infl, color=Infl)) + 
	geom_point(size=3) + geom_line(size=1.5) +
	geom_errorbar(limits, position=dodge, width=0.25) +
	facet_grid(Cont ~ Type, labeller = label_both) +
	labs(x="Satisfaction contrasts", y="log odds ratio: Satisfaction x Influence") +
	theme_bw() + 
	theme(legend.position = c(0.85, 0.07),   # c(0,0) bottom left, c(1,1) top-right
	      legend.background = element_rect(fill = "gray90", colour = "black")) +
	scale_color_discrete(name="Influence")
	      

data(Titanic)

# odds ratios for Survived and Age by Sex and Class
titanic.lor1 <- loddsratio(aperm(Titanic[,,2:1,2:1]))	
titanic.lor1

titanic.lor1.df <- as.data.frame(titanic.lor1)
ggplot(titanic.lor1.df, aes(x=Class, y=LOR, group=Sex, color=Sex)) + 
	geom_point(size=3) + geom_line(size=1.5) +
	geom_errorbar(limits, position=dodge, width=0.25) +
	labs(y="log odds ratio: Survived | Age (Adult/Child)") +
	theme_bw() + 
	theme(legend.position = c(0.75, 0.9),   # c(0,0) bottom left, c(1,1) top-right
	      legend.background = element_rect(fill = "gray90", colour = "black"))

# odds ratios for Survived and Sex by Age and Class
titanic.lor2 <- loddsratio(aperm(Titanic[,,,2:1], c(4,2,3,1)))	
titanic.lor2
titanic.lor2.df <- as.data.frame(titanic.lor2)
# should really remove the point for children in crew
titanic.lor2.df[7,"LOR"] <- NA

ggplot(titanic.lor2.df, aes(x=Class, y=LOR, group=Age, color=Age)) + 
	geom_point(size=3) + geom_line(size=1.5) +
	geom_errorbar(limits, position=dodge, width=0.25) +
	labs(y="log odds ratio: Survived | Sex (M/F)") +
	theme_bw() + 
	theme(legend.position = c(0.75, 0.9),   # c(0,0) bottom left, c(1,1) top-right
	      legend.background = element_rect(fill = "gray90", colour = "black"))







