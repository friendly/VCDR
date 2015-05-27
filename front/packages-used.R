# Find all packages loaded in book .Rnw files via library()
# Use the source, Luke!

#tcgrep -E Rnw '^library(.*)' . \
#	 | grep '/ch'  \ 
#	 | perl -p -e 's/^.*://; s/\s*#.*//' \ 
#	 | perl -p -e 's/library\(([\w\d]+)\)/"$1"/g; s/;/, /' \
#	 | sort -u | perl -p -e 's/\n/, /' > packages-used.R

packages <- c(
"AER", "ca", "car", "colorspace", "corrplot", "countreg", "directlabels", "effects", "ggparallel", "ggplot2", "ggtern", "gmodels", "gnm", "gpairs", "heplots", "Lahman", "lattice", "lmtest", "logmult", "MASS", "MASS",  "countreg", "mgcv", "nnet", "plyr", "pscl", "RColorBrewer", "reshape2", "rms", "rsm", "sandwich", "splines", "UBbipl", "vcd", "vcdExtra", "VGAM", "xtable")

