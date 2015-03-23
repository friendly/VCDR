# Vietname data

# -- this first part could be an exercise in Ch 02

data(Vietnam, package="vcdExtra")
# create array form with xtabs 
vietnam.tab <- xtabs(Freq ~ sex + year + response, data=Vietnam)
str(vietnam.tab)
# get proportions of responses for sex, year combinations
viet.prop <- prop.table(vietnam.tab, 1:2)
# show as a flat table
ftable(viet.prop)
# verify that they sum to 1 for each row
rowSums(ftable(viet.prop))
# now convert back to a data frame for ggplot ...

viet.prop.df <- data.frame(viet.prop)

# make year integer as in original Vietnam data frame

viet.prop.df$year <- as.integer(viet.prop.df$year)

# rename Freq column to Proportion
names(viet.prop.df)[4] <- "Proportion" 


library(ggplot2)

gg_prop <- ggplot(viet.prop.df,  aes(x = year, y = Proportion, color=response)) +
	geom_point(size=2.5) + 
	facet_grid(sex~.,scales="free")+ theme_bw() +
	geom_smooth(alpha=.4,size=1)+
	ggtitle("Proportion of Response by Year and Sex")

gg_prop

gg_prop + geom_smooth(method="lm", se=FALSE) 

