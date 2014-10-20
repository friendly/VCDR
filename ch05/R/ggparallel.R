# Parallel coordinate plots for categorical data

library(ggparallel)

# use + coord_flip() for vertical orientation

## example with more than two variables:
titanic <- as.data.frame(Titanic)

# parset plot
#vars <- names(titanic)[c(1, 2, 4)]
#vars <- names(titanic)[1:4]
vars <- names(titanic)[c(1, 4, 2)]
ggp <- ggparallel(vars, titanic, order=0, weight="Freq", method="parset") +
  scale_fill_brewer(palette="Paired", guide="none") +
  scale_colour_brewer(palette="Paired", guide="none")
ggp + theme_bw()

setwd("C:/Dropbox/Documents/VCDR/ch05/fig")
ggsave("titanic-par1.pdf", width=6, height=6)

#ggp + coord_flip()


ggparallel(vars, titanic, order=0, weight="Freq", method="parset") +
  scale_fill_brewer(palette="Set1", guide="none") +
  scale_colour_brewer(palette="Set1", guide="none")
  

# common angle plot
vars <- names(titanic)[c(1,4,2,3)]
ggparallel(vars, titanic, order=0, weight="Freq") +
  scale_fill_brewer(palette="Paired", guide="none") +
  scale_colour_brewer(palette="Paired", guide="none")

### hammock plot with same width lines
#ggparallel(names(titanic)[c(1,4,2,3)], titanic, weight=1, asp=0.5, method="hammock", ratio=0.2, order=c(0,0)) +
#theme( legend.position="none") +
#scale_fill_brewer(palette="Paired") +
#scale_colour_brewer(palette="Paired")

## hammock plot with line widths adjusted by frequency
ggparallel(names(titanic)[c(1,4,2,3)], titanic, weight="Freq", asp=0.5, method="hammock", order=c(0,0)) +
theme( legend.position="none")

########################################################################
# from https://raw.github.com/mariev/common_angles-paper/master/resubmit/images/images-paper.R

library(RColorBrewer)
library(ggparallel)

# define colors for factor levels
cols <- c(brewer.pal(name="Blues", 6)[-c(1,2)], 
          rev(brewer.pal(name="Reds", 3)[-1]), 
          rev(brewer.pal(name="Greens",3)[-1]))
#color_scales <- scale_fill_manual(values=cols, guide="none") +
#                scale_colour_manual(values=cols, guide="none")


vars <- names(titanic)[c(1, 4, 2)]
ggparallel(vars, titanic, order=c(0,1,1), weight="Freq", method="parset") +
  scale_fill_manual(values=cols, guide="none") +
  scale_colour_manual(values=cols, guide="none")


# hammock plot 
vars <- names(titanic)[c(1, 4, 2, 1)]
ggparallel(vars, data=titanic, weight="Freq", method="hammock", 
          order=c(0,1,1,0), ratio=.25, text.angle=0) +
  scale_fill_manual(values=cols, guide="none") +
  scale_colour_manual(values=cols, guide="none") + coord_flip()
#ggsave("hammock-titanic.pdf", width=6, height=6)

# angle plot
ggparallel(vars, data=titanic, weight="Freq", method="angle"
           order=c(0,1,1,0), text.angle=0) + 
  scale_fill_manual(values=cols, guide="none") +
  scale_colour_manual(values=cols, guide="none") + coord_flip()
#ggsave("ca-titanic.pdf", width=6, height=6)



########################################################################
# from https://github.com/heike/hammocks/blob/master/hammock_examples.R
titanic <- as.data.frame(Titanic)
#00CCCC # purple
#CCCC33 # yellow
#3333FF # blue
#FF33FF # pink
#FF3333 # red
#00CC00 # green

circos.colors <- c("#FF00FF", "#3333FF", "#FF3333", "#CCCC33", "#00CC00", "#00CCCC")
ggparallel(list("Survived", "Class"), data=titanic, weight="Freq", angle=0, order=c(1,0)) +
	coord_flip()  + scale_fill_manual(values= circos.colors, guide="none") +
	theme(legend.position="none")

qplot(Class, data=titanic, binwidth=1, fill=Survived, weight=Freq) +
	scale_fill_manual(values= c("#3333FF", "#FF33FF"))

qplot(Survived, data=titanic, binwidth=1, fill=Class, weight=Freq) +
scale_fill_manual(values= circos.colors[-(1:2)])

