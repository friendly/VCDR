# Titanic data, passengers only
require(vcdExtra)

data(Titanic, package="datasets")
Titanic1 <- Titanic[1:3,,,]
str(Titanic1)
# num [1:3, 1:2, 1:2, 1:2] 0 0 35 0 0 17 118 154 387 4 ...
# - attr(*, "dimnames")=List of 4
#  ..$ Class   : chr [1:3] "1st" "2nd" "3rd"
#  ..$ Sex     : chr [1:2] "Male" "Female"
#  ..$ Age     : chr [1:2] "Child" "Adult"
#  ..$ Survived: chr [1:2] "No" "Yes"
mosaic(Titanic1, shade=TRUE)

#Dyke <- Dyke[2:1,,,,]    # make Good the highlighted value of Knowledge
#doubledecker(Knowledge ~ ., data=Dyke)
## better version, with some options
#doubledecker(Knowledge ~ Lectures + Reading + Newspaper + Radio, data=Dyke,
#	margins = c(1,6, length(dim(Dyke)) + 1, 1), 
#	fill_boxes=list(rep(c("white", gray(.90)),4))
#	)

# make width = 2*height
doubledecker(Survived ~ ., data=Titanic1, 
	fill_boxes=list(rep(c("white", gray(.90)),4)),
	gp=gpar(fill = c(gray(.95), "lightblue"))
	)


require(MASS)
# baseline model for survived as a response
titanic1.mod0 <- loglm(~ Survived + (Class * Sex * Age), data=Titanic1)
titanic1.mod0
mosaic(titanic1.mod0)

# add one-way associations of survival with Class, Sex, Age
titanic1.mod1 <- update(titanic1.mod0, ~ . + Survived*(Class+Sex+Age))
titanic1.mod1
mosaic(titanic1.mod1, gp=shading_Friendly)

# what additional 3-way terms are needed?
add1(titanic1.mod1, ~ .^2, test="Chisq")

titanic1.mod2 <- update(titanic1.mod1, ~ . + Survived:Class:Sex)
titanic1.mod2
mosaic(titanic1.mod2, gp=shading_Friendly)

add1(titanic1.mod2, ~ .^2, test="Chisq")
titanic1.mod3 <- update(titanic1.mod2, ~ . + Survived:Class:Age)
titanic1.mod3
mosaic(titanic1.mod3, gp=shading_Friendly)

vcdExtra::summarise(loglmlist(titanic1.mod0, titanic1.mod1, titanic1.mod2, titanic1.mod3))


