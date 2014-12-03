## Demonstrate patterns of association for CMH tests

# general association

cmhdemo1 <- read.table(header=TRUE, sep="", text="
     b1  b2   b3  b4  b5
a1    0  15   25  15   0
a2    5  20    5  20   5
a3   20   5    5   5  20
")

cmhdemo1 <- as.table(as.matrix(cmhdemo1))
names(dimnames(cmhdemo1)) <- c("A", "B")

CMHtest(cmhdemo1)

#sieve(cmhdemo1, shade=TRUE, main="General association",
#	gp = shading_sieve(interpolate = 0, lty = c("solid", "longdash")))
#
#### This doesn't work.  Why???
#sieve(cmhdemo1, shade=TRUE, pop=FALSE)
#labeling_cells(text = cmhdemo1, gp_text = gpar(fontface = 2, fontsize=16))(cmhdemo1)
#
sieve(cmhdemo1, shade=TRUE, main="General association",
	labeling = labeling_cells(text=cmhdemo1, gp_text = gpar(fontface = 2, fontsize=16)))

sieve(cmhdemo1, shade=TRUE, main="General association",
	labeling = labeling_cells(text=cmhdemo1))


	
# this works:
## example with observed values in the cells:
sieve(Titanic, pop = FALSE, shade = TRUE)
labeling_cells(text = Titanic, gp_text = gpar(fontface = 2))(Titanic)
#

# linear association


cmhdemo2 <- read.table(header=TRUE, sep="", text="
     b1  b2   b3  b4  b5
a1    2   5    8   8   8
a2    2   8    8   8   5
a3    5   8    8   8   2
a4    8   8    8   5   2
")

cmhdemo2 <-  as.table(as.matrix(cmhdemo2))
names(dimnames(cmhdemo2)) <- c("A", "B")

CMHtest(cmhdemo2)

#sieve(cmhdemo2, shade=TRUE, main="Linear association",
#	gp = shading_sieve(interpolate = 0, lty = c("solid", "longdash")))

sieve(cmhdemo2, shade=TRUE, main="Linear association",
	labeling = labeling_cells(text=cmhdemo2, gp_text = gpar(fontface = 2, fontsize=16)))

# doubling the boxes
sieve(2*cmhdemo2, shade=TRUE, main="Linear association",
	labeling = labeling_cells(text=cmhdemo2, gp_text = gpar(fontface = 2, fontsize=16)))

