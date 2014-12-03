R-related ideas for VCDR
========================

1. vcdExtra

>	* DM: Which functions will be moved to vcd? I remember we considered having vcdExtra as a testbed for experimental stuff, to be moved to vcd when they were considered stable. If this is still the strategy, virtually all would have to be moved to vcd since the functions are used in the book. If not, we should set up some rule for those functions making it to vcd and those remaining in vcdExtra. Clearly, `loddsratio()` and `print.Kappa()` are candidates for vcd since they are declared as replacements. For the rest, I am unsure - maybe `collapse.table()` and `CMH_test()`, since there are already table manipulation functions and tests in vcd? And keep modeling functions like `mosaic.glm()` in vcdExtra?
  
  * MF: I agree that things in vcdExtra that are now stable and direct extensions can be moved to vcd. Certainly `print.Kappa()`, but `loddsratio()` would take a bit of work to make it a replacement for, and work with `vcd::oddsratio()`. `CMH_test()` could also be moved, but I'm not entirely happy with the formatting provided by the `print` method (gives p-values like `1e-8`).  
  

>	* DM: `Summarise()` is too generic and clashes with others. What about transforming this to a `print.glmlist()` method and using `glmlist()` instead of `Summarize()` in the book?

  * MF: Achim complained about the name too.  `Summarise()` as written is now an S3 generic, whose goal is to produce a one line summary of goodness-of-fit statistics for one or more models, given as any of an explicit list of model objects, or a glmlist or a loglmlist.  Achim proposed `logliktable`,  and I also considered `GOF` but I now think that `LRstats` is a better name than any of these. 


2. VCD

>	* DM: What about `rootogram()` in vcd? I think this should be removed because the version in countreg does a better job, and the grid version has no added value.

  * MF: At present, `rootogram()` in vcd has the added value of working with `goodfit` objects and countreg has not been released to CRAN.  Perhaps the two could be merged, using Achim's ploting code, and incorporating a method for goodfit objects (for which vcd::rootogram is the `plot()` method.)


>	* DM: Should we add default functionality for effect ordering in the strucplot framework, using e.g. correspondence analysis?

  * Yes! I had something like this in my old SAS mosaic macro.  It was only defined for two-way tables, but could be extended using mca to 3+-way tables, though with more difficulty.  But I think the way to implement this is with a separate function, `order.ca(array, dim=1)`, that would re-arrange the levels of a table according to the scores on the CA dimension `dim`. So, a call might look like

```
haireye <- order.ca(margin.table(HairEyeColor, 1:2))
mosaic(haireye, shade=TRUE)
```
	
>	* DM: What about a stratified version of `assocstats()`?

  * MF: That would be very nice! I'm assuming that it would give a list of outputs for each stratum.  Adding an argument `all=TRUE/FALSE` (or `pool=T/F`) would also be handy, to get the result for the A x B table pooled over stata.

>	* DM: Would some function for scanning contingency tables from .csv files be helpful for quickly importing existing tables?

  * MF: I can't see any general way to add value.  The main point of Chapter 2 was to describe the particular methods for importing and manipulating categorical data and converting among different representations.

>	* DM: What about a plot for logistic regression like the one in Figure 7.2?

>	* DM: I added experimental functionality for easy-plotting of several strucplots in a multi-layout to the vcd SVN. Try, e.g.:

```
A = mosaic(Titanic)
B = sieve(Titanic)
C = tile(Titanic)
D = assoc(Titanic)
vcd:::splot(A, B, C, D, layout = c(2,2))
```

I will add main= and sub= parameters and defaults for layout= depending on the number of arguments. What do you think?

  * MF:  That's very nice! However, the font sizes are not scaled down, and I don't understand why the tile plot is restricted to ~ 1/2 the x-range.

