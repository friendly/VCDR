#################################################3
# Makefile for VCDR
# -- just the beginning

# Added rule to make a VCDRzip file -- untested
#################################################3

MAIN = book

ZIP = zip

### Dependencies ###

# Straight .tex files included via \input{}
INCLUDES = inputs/pagestyle-mods.tex inputs/hyphenate.tex inputs/commands.tex front/cover.tex front/titlepage.tex front/toc.tex front/preface.tex front/overview.tex front/features.tex front/ack.tex ch01/tab/berk220.tex ch01/tab/arthrit0.tex ch01/tab/saxdata.tex ch01/tab/barley2c.tex ch01/summary.tex ch01/exercises.tex ch03/tab/saxtab.tex ch03/tab/dicetab.tex ch03/tab/horsetab.tex ch03/tab/fedtab.tex ch03/tab/buttertab.tex ch03/tab/distns.tex ch03/tab/distfuns.tex ch03/tab/soccer1.tex ch03/tab/soccer2.tex ch03/tab/pwrseries.tex ch03/tab/ordparm.tex ch03/tab/distparms.tex ch03/tab/expfamily.tex ch04/tab/berk22.tex ch04/tab/hairdat.tex ch04/tab/mental-tab.tex ch04/tab/arthrit.tex ch04/tab/rbyc.tex ch04/tab/cmh-ga.tex ch04/tab/cmh-lin.tex ch04/tab/berkrow.tex ch04/tab/berkodds.tex ch04/tab/siskel-ebert.tex ch05/boxes.tex ch05/tab/grapcons.tex ch05/tab/hyp3way.tex ch05/tab/seqmodels.tex ch05/summary.tex ch06/summary.tex ch07/tab/donner-mods.tex ch07/summary.tex ch07b/summary.tex ch08/tab/loglin-logit.tex ch08/tab/health.tex ch08/summary.tex ch08/diag-demo.tex ch10/tab/toxmod.tex ch10/summary.tex ch10/tab/birthcontrol.tex ch11/tab/link-funcs.tex ch11/tab/exp-families.tex ch11/summary.tex inputs/indsee.tex
# latex packages used anywhere
PACKAGES = krantz.cls graphicx.sty color.sty framed.sty alltt.sty array.sty times.sty fontenc.sty sfheaders.sty graphicx.sty alltt.sty mdwlist.sty comment.sty xspace.sty url.sty bm.sty titlepic.sty showlabels.sty tikz.sty xcolor.sty colortbl.sty multirow.sty epigraph.sty multicol.sty natbib.sty ifthen.sty imakeidx.sty authorindex.sty xparse.sty enumitem.sty
# all figures found from the book.log file
FIGS = front/fig/mental-plot1.png front/fig/tocmap.pdf front/fig/partmap1.pdf ch01/fig/haireye02-1.pdf ch01/fig/haireye02-2.pdf ch01/fig/spaceshuttle0-1.pdf ch01/fig/donner0-1.pdf ch01/fig/donner0-other-1.pdf ch01/fig/donner0-other-2.pdf ch01/fig/presentation-exploration2.png ch01/fig/datadisp.pdf ch01/fig/arrests-skin-color.pdf ch01/fig/TorStar/TorontoStar-graphic-2002-12-11-2.jpg ch01/fig/berk-fourfold3.pdf ch01/fig/mammograms1.pdf ch01/fig/glass-mosaic1.pdf ch01/fig/glass-mosaic2.pdf ch01/fig/iris-parallel-1.pdf ch01/fig/iris-parallel-2.pdf ch01/fig/nyt_512paths.png ch01/fig/nasa0.pdf ch01/fig/nasa.pdf ch01/fig/colors-1.pdf ch02/fig/datatypes2.pdf ch03/fig/arbuthnot1-1.pdf ch03/fig/saxony-barplot-1.pdf ch03/fig/dice-1.pdf ch03/fig/horsekicks-1.pdf ch03/fig/federalist-1.pdf ch03/fig/cyclists2-1.pdf ch03/fig/butterfly-1.pdf ch03/fig/dbinom12-1.pdf ch03/fig/dbinom2-plot2-1.pdf ch03/fig/dpois-xyplot1-1.pdf ch03/fig/dpois-xyplot2-1.pdf ch03/fig/dpois-ggplot2-1.pdf ch03/fig/dnbin3-1.pdf ch03/fig/Fed0-plots1-1.pdf ch03/fig/Fed0-plots1-2.pdf ch03/fig/Fed0-plots2-1.pdf ch03/fig/Fed0-plots2-2.pdf ch03/fig/Fed0-Fed1-1.pdf ch03/fig/Fed0-Fed1-2.pdf ch03/fig/But-fit-1.pdf ch03/fig/But-fit-2.pdf ch03/fig/ordplot1-1.pdf ch03/fig/ordplot2-1.pdf ch03/fig/ordplot3plot-1.pdf ch03/fig/ordplot3plot-2.pdf ch03/fig/distplot1.pdf ch03/fig/distplot2.pdf ch03/fig/distplot3-1.pdf ch03/fig/distplot3-2.pdf ch03/fig/distplot5-1.pdf ch03/fig/distplot5-2.pdf ch03/fig/sax-glm5-1.pdf ch03/fig/phdpubs-rootogram-1.pdf ch03/fig/phdpubs-rootogram-2.pdf front/fig/partmap2.pdf ch04/fig/bartile-1.pdf ch04/fig/bartile-2.pdf ch04/fig/spineplot-1.pdf ch04/fig/cmhdemo-1.pdf ch04/fig/cmhdemo-2.pdf ch04/fig/berk-fourfold1-1.pdf ch04/fig/berk-fourfold1-2.pdf ch04/fig/berk-fourfold3-1.pdf ch04/fig/berk-fourfold4-1.pdf ch04/fig/coalminer1-1.pdf ch04/fig/coalminer3-1.pdf ch04/fig/HE-sieve-1.pdf ch04/fig/HE-sieve-2.pdf ch04/fig/VA-sieve2-1.pdf ch04/fig/VA-sieve3-1.pdf ch04/fig/VA-cotabsieve3-1.pdf ch04/fig/berkeley-sieve-1.pdf ch04/fig/berkeley-sieve-2.pdf ch04/fig/berkeley-cotabsieve-1.pdf ch04/fig/berkeley-cotabsieve2-1.pdf ch04/fig/berkeley-sieve2-1.pdf ch04/fig/HE-assoc-1.pdf ch04/fig/HE-assoc-2.pdf ch04/fig/sexfun-agree-1.pdf ch04/fig/sexfun-agree-2.pdf ch04/fig/mammograms1-1.pdf ch04/fig/MS-agree-1.pdf ch04/fig/tripdemo2-1.pdf ch04/fig/lifeboats1-1.pdf ch04/fig/lifeboats2-1.pdf ch05/fig/haireye-mos1-1.pdf ch05/fig/haireye-mos4-1.pdf ch05/fig/haireye-mos4-2.pdf ch05/fig/haireye-mos8-1.pdf ch05/fig/haireye-mos9-1.pdf ch05/fig/struc.pdf ch05/fig/HE-fill-1.pdf ch05/fig/HE-fill-2.pdf ch05/fig/HE-interp-1.pdf ch05/fig/HE-interp-2.pdf ch05/fig/HE-shading-1.pdf ch05/fig/HE-shading-2.pdf ch05/fig/arth-mosaic-1.pdf ch05/fig/arth-mosaic-2.pdf ch05/fig/UKsoccer-mosaic-1.pdf ch05/fig/HEC-mos1b-1.pdf ch05/fig/HEC-mos1-1.pdf ch05/fig/HEC-mos2-1.pdf ch05/fig/HEC-mos2-2.pdf ch05/fig/HEC-seq1.pdf ch05/fig/HEC-seq2.pdf ch05/fig/HEC-seq3.pdf ch05/fig/presex2-1.pdf ch05/fig/presex2-2.pdf ch05/fig/presex3-1.pdf ch05/fig/presex3-2.pdf ch05/fig/employ-mos1-1.pdf ch05/fig/employ-mos2-1.pdf ch05/fig/employ-mos3-1.pdf ch05/fig/employ-mos3-2.pdf ch05/fig/punish-cond1-1.pdf ch05/fig/punish-cond2-1.pdf ch05/fig/bartlett-pairs-1.pdf ch05/fig/marital-pairs-1.pdf ch05/fig/berk-pairs1-1.pdf ch05/fig/berk-pairs2-1.pdf ch05/fig/berk-pairs3-1.pdf ch05/fig/arth-gpairs-1.pdf ch05/fig/mos3d-bartlett.png ch05/fig/struc-mos1-1.pdf ch05/fig/struc-mos2-1.pdf ch05/fig/struc-mos3-1.pdf ch05/fig/struct-mos3d1.png ch05/fig/struc-mos4-1.pdf ch05/fig/berkeley-doubledecker-1.pdf ch05/fig/titanic-doubledecker-1.pdf ch05/fig/lor1.png ch05/fig/lor2.png ch05/fig/pun-lor-plot-1.pdf ch05/fig/titanic-lor-plot-1.pdf ch05/fig/titanic-lor-plot-2.pdf ch06/fig/ca-haireye-plot-1.pdf ch06/fig/ca-mental-plot-1.pdf ch06/fig/ca-victims-plot-1.pdf ch06/fig/TV2-ca.pdf ch06/fig/TV2-mosaic.pdf ch06/fig/stacking.pdf ch06/fig/ca-suicide-plot-1.pdf ch06/fig/ca-suicide-mosaic-1.pdf ch06/fig/ca-suicide-sup-1.pdf ch06/fig/mca-haireye1-1.pdf ch06/fig/presex-mca-plot-1.pdf ch06/fig/titanic-mca-plot-1.pdf ch06/fig/Scalarproduct.pdf ch06/fig/ca-suicide-biplot-1.pdf ch06/fig/cabipl-suicide.pdf ch06/fig/bidemo.pdf ch06/fig/biplot-soccer-plot-1.pdf front/fig/partmap3.pdf ch07/fig/goverview-R1.jpg ch07/fig/arthritis-ols.pdf ch07/fig/arthritis-age.pdf ch07/fig/arth-logi-hist-1.pdf ch07/fig/arthritis-age2-1.pdf ch07/fig/nasa-temp-ggplot.pdf ch07/fig/arth-cond1-1.pdf ch07/fig/arth-cond2-1.pdf ch07/fig/arth-full1-1.pdf ch07/fig/arth-full2-1.pdf ch07/fig/arth-effplot1-1.pdf ch07/fig/arth-effplot2-1.pdf ch07/fig/arth-effplot3-1.pdf ch07/fig/donner1-spineplot-1.pdf ch07/fig/donner1-gpairs-1.pdf ch07/fig/donner1-cond1-1.pdf ch07/fig/donner1-cond3-1.pdf ch07/fig/donner1-cond3-2.pdf ch07/fig/donner-effect-1.pdf ch07/fig/arrests-eff1-1.pdf ch07/fig/arrests-eff2-1.pdf ch07/fig/arrests-eff2-2.pdf ch07/fig/arrests-all-1.pdf ch07/fig/icu-odds-ratios-cropped.pdf ch07/fig/icu-nomogram.pdf ch07/fig/icu1-fit-plot-1.pdf ch07/fig/donner2-plot-1.pdf ch07/fig/donner2-plot5-1.pdf ch07/fig/donner2-inflplot-1.pdf ch07/fig/donner2-indexinfl-1.pdf ch07/fig/icu2-inflplot-1.pdf ch07/fig/icu2-infl-index-1.pdf ch07/fig/icu2-dbage-1.pdf ch07/fig/icu2-dbscatmat-1.pdf ch07/fig/donner-cr1-1.pdf ch07/fig/donner-cr2-1.pdf ch07/fig/joint.pdf ch07/fig/donner4-avp-1.pdf ch07/fig/donner4-avp-2.pdf ch07/fig/icu3-marginal-1.pdf ch07/fig/icu3-avp1-1.pdf ch07/fig/icu3-avp2-1.pdf ch07b/fig/podds2.pdf ch07b/fig/podds1.pdf ch07b/fig/latent.pdf ch07b/fig/arth-rmsplot-1.pdf ch07b/fig/arth-polr1-1.pdf ch07b/fig/arth-po-eff1-1.pdf ch07b/fig/arth-po-eff1-2.pdf ch07b/fig/arth-po-eff2-1.pdf ch07b/fig/arth-po-eff3-1.pdf ch07/fig/nested2.jpg ch07/fig/nested1c.jpg ch07b/fig/wlf-fitted-prob-1.pdf ch07b/fig/wlf-fitted-logit-1.pdf ch07b/fig/wlf-multi-prob-1.pdf ch07b/fig/wlf-multi-effect-1.pdf ch08/fig/stres-plot-1.pdf ch08/fig/berk-glm1-mosaic-1.pdf ch08/fig/berk-glm3-mosaic-1.pdf ch08/fig/berk-logit2.pdf ch08/fig/berk-logit3.pdf ch08/fig/health-mosaic-1.pdf ch10/fig/assoc-models.png ch10/fig/mental-lorplot.pdf ch10/fig/mental-indep-1.pdf ch10/fig/mental-RC1.pdf ch10/fig/mental-RC2.pdf ch10/fig/mental-logmult-rc2.pdf ch10/fig/vision-mosaics-1.pdf ch10/fig/vision-mosaics-2.pdf ch10/fig/hauser-lor-plot-1.pdf ch10/fig/hauser-mosaic1-1.pdf ch10/fig/hauser-mosaic1-2.pdf ch10/fig/hauser-mosaic2-1.pdf ch10/fig/hauser-mosaic3-1.pdf ch10/fig/hauser-sumry-plot-1.pdf ch10/fig/vision2-qsymm-1.pdf ch10/fig/vision2-hetqsymm-1.pdf ch10/fig/cm-blogits-1.pdf ch10/fig/cm-mosaic1-1.pdf ch10/fig/cm-vglm1-prob.pdf ch10/fig/cm-vglm1-logit.pdf ch10/fig/cm-vglm2-blogit.pdf ch10/fig/tox-mosaic1-1.pdf ch10/fig/tox-mosaic1-2.pdf ch10/fig/tox-mosaic2-1.pdf ch10/fig/tox-mosaic3-1.pdf ch10/fig/tox-fourfold-crop.pdf ch10/fig/tox-LOR-1.pdf ch10/fig/tox-effplots-1.pdf ch10/fig/tox-effplots-2.pdf ch10/fig/tox-glm-logits1.pdf ch10/fig/tox-glm-logits2.pdf ch10/fig/tox-glm-logits3.pdf ch11/fig/phdpubs-barplot1.pdf ch11/fig/phdpubs-barplot2.pdf ch11/fig/phdpubs-logplots-1.pdf ch11/fig/phdpubs-logplots-2.pdf ch11/fig/phdpubs1-effpois-1.pdf ch11/fig/crabs1-gpairs-1.pdf ch11/fig/crabs1-scats-1.pdf ch11/fig/crabs1-scats-2.pdf ch11/fig/crabs1-boxplots-1.pdf ch11/fig/crabs1-boxplots-2.pdf ch11/fig/crabs1-eff1-1.pdf ch11/fig/phd-mean-var-plot-1.pdf ch11/fig/phdpubs4-rootogram-1.pdf ch11/fig/phdpubs4-rootogram-2.pdf ch11/fig/crabs2-rootogram-1.pdf ch11/fig/crabs2-rootogram-2.pdf ch11/fig/ExcessZeros.pdf ch11/fig/zipois-plot-1.pdf ch11/fig/zipois-plot-2.pdf ch11/fig/crabs-zero-spinogram-1.pdf ch11/fig/crabs-zero-cdplot-1.pdf ch11/fig/cod1-gpairs-1.pdf ch11/fig/cod1-doubledecker-1.pdf ch11/fig/cod1-mosaic-1.pdf ch11/fig/cod1-length-prevalence-1.pdf ch11/fig/cod1-boxplot-1.pdf ch11/fig/cod1-length-scat-1.pdf ch11/fig/cod2-rootograms-1.pdf ch11/fig/cod3-eff1-1.pdf ch11/fig/cod3-eff1-2.pdf ch11/fig/cod3-eff2-1.pdf ch11/fig/cod3-eff2-2.pdf ch11/fig/nmes-visits-1.pdf ch11/fig/nmes-visits-2.pdf ch11/fig/nmes-boxplots-1.pdf ch11/fig/nmes-school-1.pdf ch11/fig/nmes2-eff1-1.pdf ch11/fig/nmes2-eff2-1.pdf ch11/fig/nmes2-eff3-1.pdf ch11/fig/nmes2-eff3-2.pdf ch11/fig/nmes2-eff4-1.pdf ch11/fig/nmes2-eff4-2.pdf ch11/fig/nmes3-eff1-1.pdf ch11/fig/nmes3-rsm-1.pdf ch11/fig/nmes3-rsm-2.pdf ch11/fig/phdpubs5-plot-1.pdf ch11/fig/phdpubs5-resplot1-1.pdf ch11/fig/phdpubs5-resplot1-2.pdf ch11/fig/phdpubs5-resplot2-1.pdf ch11/fig/phdpubs5-resplot2-2.pdf ch11/fig/phdpubs5-influenceplot-1.pdf ch11/fig/phdpubs6-qqplot-1.pdf ch11/fig/phd-halfnorm.pdf ch11/fig/phdpubs6-res-plots-1.pdf ch11/fig/phdpubs6-res-plots-2.pdf ch11/fig/nmes4-hepairs-1.pdf ch11/fig/nmes4-fourfold1-1.pdf ch11/fig/nmes4-fourfold2-1.pdf ch11/fig/nmes4-loddsratio-1.pdf ch11/fig/nmes-eff-health.pdf

#
BIB_FILES = ./references.bib
#

# For the ZIP file
TOP = book.*
EXCLUDES = 


# Rnw files -- these lists have NOT been updated and aren't used
CHAP_RNW = ch01.Rnw ch02.Rnw ch03.Rnw ch04.Rnw ch05.Rnw ch06.Rnw ch07.Rnw ch08.Rnw ch11.Rnw

CHILD_RNW = ch01/interactive.Rnw ch02/exercises.Rnw ch03/exercises.Rnw ch04/exercises.Rnw ch05/exercises.Rnw ch05/parallel.Rnw ch06/exercises.Rnw ch07/arrests.Rnw ch07/donner1.Rnw ch07/donner2.Rnw ch07/exercises.Rnw ch07/icu1.Rnw ch07/icu2.Rnw ch07/propodds.Rnw ch08/coalminers.Rnw ch08/exercises.Rnw ch08/health.Rnw ch08/multiv.Rnw ch08/ordinal.Rnw ch08/square.Rnw ch08/toxaemia.Rnw ch11/cod1.Rnw ch11/cormorants.Rnw ch11/count.Rnw ch11/crabs1.Rnw ch11/multiv.Rnw ch11/nmes1.Rnw ch11/nmes-multiv.Rnw ch11/zeros.Rnw 


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


VCDRzip :
	$(ZIP) -r VCDR $(TOP)  $(INCLUDES) $(FIGS)  -x $(EXCLUDE)


##############
# cleaning
##############
# clean the directory after compiling
clean : iclean aclean

# remove untracked files
iclean :
	git clean -f 

# revert all files that have not been staged
aclean :
	git checkout -- .


