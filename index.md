# This will become the webpage for the forthcoming book

## "Discrete Data Analysis with R"

by Michael Friendly and David Meyer

Chapman & Hall (2015)
ISBN 978-1-4822-6384-8

## The page will include

- About this book
- Table of Contents
- Code for all graphics
- Updates
- Errata
- Reviews

## Advice on using this book

- R Packages
 
  To prepare your R installation for running the examples in the book, you can use the following commands to install
  all the packages directly used in examples.

```
packages <- c(
  "AER", "ca", "car", "colorspace", "corrplot", "countreg", "directlabels", "effects", "ggparallel", "ggplot2", "ggtern", "gmodels", "gnm", "gpairs", "heplots", "Lahman", "lattice", "lmtest", "logmult", "MASS", "mgcv", "nnet", "plyr", "pscl", "RColorBrewer", "reshape2", "rms", "rsm", "sandwich", "splines", "vcd", "vcdExtra", "VGAM", "xtable")
install.packages(packages)
```

  The main R packages used in the book are `ggplot2`, `vcd` and `vcdExtra`.  You can arrange for these to loaded automatically
  whenever you start R by including the following lines in your `.Rprofile` file

```
library (ggplot2)
library (vcd)
library (vcdExtra)
```


## Datasets

All datasets used in the book are available in R or in one of its accompanying packages.  
A few additional datasets have been made available the vcdExtra package.



## Publisher's webpage:

How to order

author's email address:  friendly@yorku.ca




