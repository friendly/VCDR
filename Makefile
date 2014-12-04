#################################################3
# Makefile for VCDR
# -- just the beginning
#################################################3

MAIN = book

### Dependencies ###

# Straight .tex files included via \input{}
INPUTS = inputs/hyphenate.tex inputs/commands.tex front/cover.tex front/toc.tex front/preface.tex ch01/tab/berk220.tex ch01/tab/arthrit0.tex ch01/tab/saxdata.tex ch01/tab/barley2c.tex ch01/summary.tex ch01/exercises.tex ch03/tab/saxtab.tex ch03/tab/dicetab.tex ch03/tab/horsetab.tex ch03/tab/fedtab.tex ch03/tab/buttertab.tex ch03/tab/distns.tex ch03/tab/distfuns.tex ch03/tab/soccer1.tex ch03/tab/soccer2.tex ch03/tab/pwrseries.tex ch03/tab/ordparm.tex ch03/tab/distparms.tex ch03/tab/expfamily.tex ch04/tab/berk22.tex ch04/tab/hairdat.tex ch04/tab/mental-tab.tex ch04/tab/arthrit.tex ch04/tab/rbyc.tex ch04/tab/cmh-ga.tex ch04/tab/cmh-lin.tex ch04/tab/berkrow.tex ch04/tab/berkodds.tex ch04/tab/siskel-ebert.tex ch05/boxes.tex ch05/tab/grapcons.tex ch05/tab/hyp3way.tex ch05/tab/seqmodels.tex ch05/summary.tex ch06/summary.tex ch07/tab/donner-mods.tex ch07/summary.tex ch08/tab/loglin-logit.tex ch08/tab/health.tex ch08/diag-demo.tex ch08/tab/toxmod.tex ch08/summary.tex ch08/tab/birthcontrol.tex ch09/tab/link-funcs.tex ch09/tab/exp-families.tex ch09/summary.tex inputs/indsee.tex
#
BIB_FILES = ./references.bib
#

# Rnw files
CHAP_RNW = ch01.Rnw ch02.Rnw ch03.Rnw ch04.Rnw ch05.Rnw ch06.Rnw ch07.Rnw ch08.Rnw ch09.Rnw

CHILD_RNW = ch01/interactive.Rnw ch02/exercises.Rnw ch03/exercises.Rnw ch04/exercises.Rnw ch05/exercises.Rnw ch05/parallel.Rnw ch06/exercises.Rnw ch07/arrests.Rnw ch07/donner1.Rnw ch07/donner2.Rnw ch07/exercises.Rnw ch07/icu1.Rnw ch07/icu2.Rnw ch07/propodds.Rnw ch08/coalminers.Rnw ch08/exercises.Rnw ch08/health.Rnw ch08/multiv.Rnw ch08/ordinal.Rnw ch08/square.Rnw ch08/toxaemia.Rnw ch09/cod1.Rnw ch09/cormorants.Rnw ch09/count.Rnw ch09/crabs1.Rnw ch09/multiv.Rnw ch09/nmes1.Rnw ch09/nmes-multiv.Rnw ch09/zeros.Rnw 


# some rules
############
%.tex:%.Rnw
	Rscript \
		-e "library(knitr)" \
		-e "knitr::knit('$<', '$@')"

%.pdf:%.Rnw
	Rscript \
		-e "library(knitr)" \
		-e "knitr::knit2pdf('$<', '$@')"


# targets
############

index :
#  subject index
	makeindex -o book.ind -s book.ist book.idx
#  example index
	makeindex -o book.ine book.ide
#  author/editor index -- requires authorindex script
	perl authorindex -d book

references.bib :
	perl aux2bib book

