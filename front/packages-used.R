# Find all packages loaded in book .Rnw files via library()
# Use the source, Luke!

#tcgrep -E Rnw '^library(.*)' . \
#	 | grep '/ch'  \ 
#	 | perl -p -e 's/^.*://; s/\s*#.*//' \ 
#	 | perl -p -e 's/library\(([\w\d]+)\)/"$1"/g; s/;/, /' \
#	 | sort -u | perl -p -e 's/\n/, /' > packages-used.R

packages <- c(
"AER", "ca", "car", "colorspace", "corrplot", "countreg", "directlabels", "effects", "ggparallel", "ggplot2", "ggtern", "gmodels", "gnm", "gpairs", "heplots", "Lahman", "lattice", "lmtest", "logmult", "MASS", "mgcv", "nnet", "plyr", "pscl", "RColorBrewer", "reshape2", "rms", "rsm", "sandwich", "splines", "UBbipl", "vcd", "vcdExtra", "VGAM", "xtable")

library(devtools)
pkg_info <- devtools:::package_info(packages)
# clean up unwanted
pkg_info$source <- sub(" \\(R.*\\)", "", pkg_info$source)
pkg_info <- pkg_info[,-2]

pkg_info


xtable(pkg_info)

library(xtable)
print(xtable(pkg_info), include.rownames=FALSE, floating=FALSE)

print(xtable(pkg_info, align=c("l", ">{\\textsf}", "l", "l", "l")), include.rownames=FALSE, floating=FALSE)


	> pkg_info
	 package      version   date       source 
	 AER          1.2-3     2015-02-24 CRAN   
	 ca           0.60      2015-03-01 R-Forge
	 car          2.0-25    2015-03-03 R-Forge
	 colorspace   1.2-6     2015-03-11 CRAN   
	 corrplot     0.73      2013-10-15 CRAN   
	 countreg     0.1-2     2014-10-17 R-Forge
	 directlabels 2013.6.15 2013-07-23 CRAN   
	 effects      3.0-4     2015-03-22 R-Forge
	 ggparallel   0.1.1     2012-09-09 CRAN   
	 ggplot2      1.0.1     2015-03-17 CRAN   
	 ggtern       1.0.5.0   2015-04-15 CRAN   
	 gmodels      2.15.4.1  2013-09-21 CRAN   
	 gnm          1.0-8     2015-04-22 CRAN   
	 gpairs       1.2       2014-03-09 CRAN   
	 heplots      1.0-15    2015-04-18 CRAN   
	 Lahman       3.0-1     2014-09-13 CRAN   
	 lattice      0.20-31   2015-03-30 CRAN   
	 lmtest       0.9-33    2014-01-23 CRAN   
	 logmult      0.6.2     2015-04-22 CRAN   
	 MASS         7.3-40    2015-03-21 CRAN   
	 MASS         7.3-40    2015-03-21 CRAN   
	 mgcv         1.8-6     2015-03-31 CRAN   
	 nnet         7.3-9     2015-02-11 CRAN   
	 plyr         1.8.2     2015-04-21 CRAN   
	 pscl         1.4.9     2015-03-29 CRAN   
	 RColorBrewer 1.1-2     2014-12-07 CRAN   
	 reshape2     1.4.1     2014-12-06 CRAN   
	 rms          4.3-1     2015-05-01 CRAN   
	 rsm          2.7-2     2015-05-13 CRAN   
	 sandwich     2.3-3     2015-03-26 CRAN   
	 UBbipl       3.0.4     2013-10-13 local  
	 vcd          1.4-0     2015-04-20 local  
	 vcdExtra     0.6-8     2015-04-16 CRAN   
	 VGAM         0.9-8     2015-05-11 CRAN   
	 xtable       1.7-4     2014-09-12 CRAN   
>