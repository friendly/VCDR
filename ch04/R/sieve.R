# \S 4.5 sieve diagrams

# need to have a table object for labeling_cells
haireye <- margin.table(HairEyeColor, 1:2)
#sieve(haireye, sievetype="expected", shade=TRUE)

### This works, observed values in cells  
sieve(haireye, shade=TRUE, pop=FALSE, main="Observed frequencies")
labeling_cells(text = haireye, gp_text = gpar(fontface = 2))(haireye)

	
# calculate expected frequencies
expected <- outer(apply(haireye, 1, sum),
                  apply(haireye, 2, sum)) / sum(haireye)
expected <- as.table(expected)
names(dimnames(expected)) <- names(dimnames(haireye))


## using labeling_cells
#sieve(expected, shade=TRUE, sievetype="expected", pop=FALSE, main="Expected frequencies")
#labeling_cells(text = round(expected,1), gp_text = gpar(fontface = 2))(expected)

## Much easier:

#  from David: Well, for me the following works:

expected = independence_table(haireye)
sieve(haireye, shade=TRUE, sievetype="expected", pop=FALSE)
labeling_cells(text = round(expected,1), gp_text = gpar(fontface = 2))(haireye)

sieve(haireye, sievetype = "expected", shade = TRUE, main="Expected frequencies",
labeling = labeling_values, value_type = "expected", gp_text = gpar(fontface = 2))

sieve(haireye, shade = TRUE, main="Observed frequencies",
labeling = labeling_values, value_type = "observed", gp_text = gpar(fontface = 2))


######################################################

## an example for the formula interface:
# -- this is for men & women together
data("VisualAcuity", package="vcd")
sieve(Freq ~ right + left,  data = VisualAcuity, shade=TRUE)

# re-assign names/dimnames
VA.tab <- xtabs(Freq ~ right + left + gender, data=VisualAcuity)
dimnames(VA.tab)[1:2] <- list(c("high", 2, 3, "low"))
names(dimnames(VA.tab))[1:2] <- paste(c("Right", "Left"), "eye grade")
str(VA.tab)

sieve(VA.tab, shade=TRUE)

sieve(VA.tab[,,"female"], shade=TRUE)

# do this directly from VisualAcuity?

# larger tables

sieve(Freq ~ right + left |gender,  data = VisualAcuity, shade=TRUE)

# cotabplot version -- would be nicer if the aspect ratio /spacing of the
# panels was better

cotabplot(Freq ~ right + left |gender,  data = VisualAcuity, panel=cotab_sieve, shade=TRUE)
 
#################################################################

sieve(UCBAdmissions, shade=TRUE, condvar='Gender') 

# labeling_cells doesn't work with conditioning
sieve(UCBAdmissions, shade=TRUE, condvar='Gender', pop=FALSE) 
labeling_cells(text = UCBAdmissions, gp_text = gpar(fontface = 2))(UCBAdmissions)

sieve(UCBAdmissions, shade=TRUE, pop=FALSE) 
labeling_cells(text = UCBAdmissions, gp_text = gpar(fontface = 2))(UCBAdmissions)

# re-ordered, Dept first, printing cell frequencies
UCB <- aperm(UCBAdmissions, c(3,1,2))
dimnames(UCB)[[3]] <- c("M", "F")   # abbreviate for display
sieve(UCB, shade=TRUE, pop=FALSE) 
labeling_cells(text = UCB, gp_text = gpar(fontface = 2))(UCB)

# the same, using abbreviate_labs
UCB <- aperm(UCBAdmissions, c(3,1,2))
sieve(UCB, shade=TRUE, pop=FALSE, abbreviate_labs=c(FALSE, FALSE, TRUE)) 
labeling_cells(text = UCB, gp_text = gpar(fontface = 2))(UCB)

# flattened table, corresponding to the loglinear model [AdmitGender][Dept]
# NB: can now do this more simply using as.matrix.structable()

UCB.df <- as.data.frame(UCBAdmissions)
UCB.df$`Admit:Gender` <- paste(UCB.df$Admit, substr(UCB.df$Gender,1,1), sep=':')
UCB.tab2 <- xtabs(Freq ~ `Admit:Gender` + Dept, data=UCB.df)
UCB.tab2
sieve(UCB.tab2, shade=TRUE)



UCB.stab <- structable(Dept ~ Admit+Gender, data=UCBAdmissions)
sieve(UCB.stab, shade=TRUE)

# specifying a model formula
sieve(UCB.stab, shade=TRUE, expected=~Admit*Gender+Dept)                                                                                                            

sieve(UCBAdmissions, shade=TRUE, expected=~Admit*Gender+Dept)

UCB2 <- aperm(UCBAdmissions, c(3,2,1))
sieve(UCB2, shade=TRUE, expected=~Admit*Gender+Dept, split_vertical=c(F,T,T))
 
           