# test David's loddsratio

library(vcd)

## 4 way tables 
data(Punishment, package="vcd")
punish <- xtabs(Freq ~ memory + attitude + age + education, data = Punishment)
#mosaic(~ age + education + memory + attitude, data = punish, keep = FALSE,
#       gp = gpar(fill = grey.colors(2)), spacing = spacing_highlighting,
#       rep = c(attitude = FALSE))
mosaic(attitude ~ age + education + memory, data = Punishment,
	highlighting_direction="left", rep = c(attitude = FALSE))

pun.lor <- loddsratio(punish)

# should handle lwd
plot(pun.lor, cex=1, lwd=2, whiskers=0.05)

# visualize the log odds ratios, by age and education
pun.lor <- loddsratio(~ attitude + memory | age + education, data = Punishment)
plot(pun.lor, cex=1, lwd=2, whiskers=0.05, conf_level=0.68)


###################################################
data(Titanic)

# odds ratios for Survived and Age by Sex and Class
titanic.lor1 <- loddsratio(~Survived + Age | Class + Sex, data=Titanic)
plot(titanic.lor1, cex=1, conf_level=0.68, whiskers=0.05)

# odds ratios for Survived and Sex by Age and Class
titanic.lor2 <- loddsratio(~Survived + Sex | Class + Age, data=Titanic[,,,2:1])
plot(titanic.lor2, cex=1, conf_level=0.68, whiskers=0.05)

# how to use ref level???
titanic.lor2 <- loddsratio(~Survived + Sex | Class + Age, data=Titanic, ref=c(1,1))
## Error in Rix[i, ] : incorrect number of dimensions




###################################################
# housing data: needs trellis layout

data(housing, package="MASS")

housing.tab <- xtabs(Freq ~ Sat + Infl + Type + Cont, data=housing)
mosaic(aperm(housing.tab), shade=TRUE)

housing.lor <- loddsratio(Freq ~ Sat + Infl | Type + Cont, data=housing)

plot(housing.lor)

#housing.tab <- xtabs(Freq ~ Sat + Infl + Type + Cont, data=housing)
#housing.lor <- loddsratio(housing.tab)
housing.lor.df <- as.data.frame(housing.lor)

housing.aov <- lm(LOR ~ Type + Cont, data=housing.lor.df, weights = 1/ASE^2)
anova(housing.aov)


housing.lor.df$Sat <- sub("Medium", "Med", housing.lor.df$Sat)
housing.lor.df$Infl <- sub("Medium", "Med", housing.lor.df$Infl)

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




data(VisualAcuity, package="vcd")
vis.tab <- xtabs(Freq ~ left + right + gender, data=VisualAcuity)

vis.lor <- loddsratio(vis.tab)



