haireye <- margin.table(HairEyeColor, 1:2)
mosaic(haireye)

mosaic(haireye, pop=FALSE)
labeling_cells(text = haireye, gp_text = gpar(fontface=2), clip=FALSE)(haireye)


(hair <- margin.table(haireye,1))
prop.table(hair)

# one way
mosaic(hair, pop=FALSE)
labeling_cells(text = hair, gp_text = gpar(fontface=2), clip=FALSE)(hair)

expected <- rep(sum(haireye)/4, 4)
names(expected) <- names(hair)
expected
residuals <- (hair - expected) / sqrt(expected)
mosaic(hair, shade=TRUE, expected=expected, df=3)
mosaic(hair, shade=TRUE, expected=expected, df=3, labeling=labeling_residuals)
mosaic(hair, shade=TRUE, expected=expected, df=3, legend=FALSE,
  labeling=labeling_residuals, suppress=0, gp_text=gpar(fontface=2))
 

chisq <- sum(residuals^2)
pchisq(chisq, 3, lower.tail=FALSE)

# two way
prop.table(haireye, 1)
addmargins(prop.table(haireye, 1), 2)

# show residuals in cells
mosaic(haireye, shade=TRUE, suppress=0, 
       labeling=labeling_residuals, gp_text=gpar(fontface=2))

HE.mod <- loglm(~ Hair + Eye, data=haireye)
round(resids <- residuals(HE.mod, type="pearson"),2)

# show chisq.test
(chisq <- sum(resids^2))
(df <- prod(dim(haireye)-1))
#pchisq(chisq, df, lower.tail=FALSE)

chisq.test(haireye)

# re-order Eye colors
haireye2 <- haireye[, c("Brown", "Hazel", "Green", "Blue")]
mosaic(haireye2, shade=TRUE)

###################################################
# shadings

# Marimekko charts / Mondrian
#fill_colors <- matrix(palette()[2:9], ncol=4)
#mosaic(haireye2, gp=gpar(fill=fill_colors, col=0))
fill_colors <- matrix(palette()[2:5], ncol=4)
mosaic(haireye2, gp=gpar(fill=fill_colors, col=0))

# toeplitz designs
toeplitz(2:5)
fill_colors <- palette()[toeplitz(2:5)]
mosaic(haireye2, gp=gpar(fill=fill_colors, col=0))

#fill_colors <- hsv(s=(4:1)/4)[toeplitz(2:5)]
#mosaic(haireye2, gp=gpar(fill=fill_colors, col=0))



# color by hair color
fill_colors <- c("brown4", "#acba72", "green", "lightblue")
(fill_colors <- t(matrix(rep(fill_colors, 4), ncol=4)))
mosaic(haireye2, gp=gpar(fill=fill_colors, col=0))

# how to modify label font?
#mosaic(haireye2, gp=gpar(fill=fill_colors, col=0), labeling_args=gpar(fontface=2))


mosaic(haireye2, type="expected", shade=TRUE)

mosaic(haireye2, gp=shading_Friendly, legend=legend_fixed)
mosaic(haireye2, gp=shading_max)

# more shading levels
mosaic(haireye2, shade=TRUE, gp_args=list(interpolate=1:4))

# continuous shading
interp <- function(x) pmin(x/6, 1)
mosaic(haireye2, shade=TRUE, gp_args=list(interpolate=interp))

##############################################

# \S 5.4
# Three way table, joint independence, [HE][S}

#mosaic(~ Hair + Eye + Sex, data=HairEyeColor, expected = ~ Hair*Eye + Sex, labeling=labeling_residuals)

HEC <- HairEyeColor[, c("Brown", "Hazel", "Green", "Blue"),]
mosaic(HEC, expected = ~ Hair*Eye + Sex, labeling=labeling_residuals)

abbrev <- list(abbreviate=c(FALSE, FALSE, 1))
mosaic(HEC, expected = ~ Hair + Eye + Sex, mosaic(HEC, expected = ~ Hair*Eye + Sex, labeling=labeling_residuals),
	main="Model: ~Hair + Eye + Sex")

mosaic(HEC, expected = ~ Hair*Sex + Eye*Sex, labeling_args=abbrev
	main="Model: ~Hair*Sex + Eye*Sex")

#mosaic(HEC, expected = ~ (Hair + Eye + Sex)^2, labeling_args=abbrev)

library(MASS)
mod1 <- loglm(~ Hair + Eye + Sex, data=HEC)
mod2 <- loglm(~ Hair*Sex + Eye*Sex, data=HEC)
mod3 <- loglm(~ Hair*Eye + Sex, data=HEC)
anova(mod1, mod2, mod3, test="chisq")

summarise(loglmlist(Mutual=mod1, Condit=mod2, Joint=mod3))

############################################

# \S 5.4.1 sequential models

mosaic(HEC, expected = ~ Hair + Eye + Sex, legend=FALSE, labeling_args=abbrev, main="Mutual")

mosaic(~ Hair + Eye, data=HEC, shade=TRUE, legend=FALSE, main="Marginal")

mosaic(HEC, expected = ~ Hair*Eye + Sex, legend=FALSE, labeling_args=abbrev, main="Joint")

############################################
# model generating functions

loglin2string(mutual(5, factors=LETTERS[1:5]))
loglin2string(joint(5, factors=LETTERS[1:5]))
loglin2string(conditional(5, factors=LETTERS[1:5]))
loglin2string(markov(5, factors=LETTERS[1:5]))

for(nf in 2:5) {
	print(loglin2string(mutual(nf, factors=LETTERS[1:5])))
}

for(nf in 2:5) {
	print(loglin2string(joint(nf, factors=LETTERS[1:5])))
}

for(nf in 2:5) {
	print(loglin2string(conditional(nf, factors=LETTERS[1:5]), sep=""))
}

for(nf in 2:5) {
	print(loglin2formula(conditional(nf, factors=LETTERS[1:5])))
}

 
mutual(3, table=HEC)
loglin2string(mutual(3, table=HEC))
loglin2string(conditional(3, table=HEC))
loglin2formula(conditional(3, table=HEC))

# requires latest update to vcdExtra ...
HEC.mods <- seq_loglm(HEC, type="joint")
summarise(HEC.mods)
# show model strings ...
unlist(lapply(HEC.mods, function(x) x$model.string))
 


