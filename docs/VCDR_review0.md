Review of VCD with R
====================

I will start with some general remarks, then chapterwise comments.

General Remarks
---------------

The book really represents an impressive collection of conceptual and computational techniques. The only topic really missing is interactive graphics, but this cannot be treated in a (physical) book, and R is not quite the right software for this (even though interfaces to iPlots etc. exist).

### Less is more

The downside of this is an increased risk of **"featuritis"**. In chapters 7 and 8, especially for multivariate methods, I got a little bit the feeling of "yet another method", especially since the chapters are currently quite long and these methods tackle more special topics.

This impression gets increased by the fact that these methods are implemented in several packages, sometimes redundant, sometimes incompatible, so we also get the "yet another package" issue here. In case of equivalent approaches (in base R or different packages), it would be nice to have some guidance when to prefer method/package A over B. For example, sometimes we use ftable, sometimes structable, but there is never an explanation about pros/cons. (Actually, I wrote structable as a real replacement for ftable, so I would suggest not to use ftable at all).

In short: maybe less is more for some chapters, both for the statistical methods and the R packages/methods used.

### Audience not well addressed

Another important, somewhat related issue concerns the **scope of the book** with respect to stated target audience:

* students (not necessarily studying statistics)
* researchers

I think these are two very different groups, students focusing on the general ideas and researchers more concerned about practical issues, typically requiring very customized approaches (conceptually and computationally). Currently, the book tries to satisfy the need of both, but IMO does not clearly distinguish between them. I wonder whether we should split the book into 3 parts:

1. Basics (with intro, distributions, R stuff, including graphics)
2. Core Methods (2D/n-way mosaics, corresp.-analysis, logistic regression, loglinear models, but just the common models)
3. Advanced Methods (Multivariate methods, ordinal variables, count models).

Not sure about GLMs: I have the impression that the knowledge about this is assumed in almost all chapters, implicitly or explicitly. This starts already in chapter 3, but GLMs are officially introduced in the last chapter only. I think topics like GLM (at least the main idea) and before that maybe also maximum likelihood/likelihood ration tests should go in a chapter on "statistic basics" in the "Basics" part of the book, and so the main chapters could more concentrate on the graphical methods.

Also, people familiar with the "Basics" (R and/or statistics) could just skip the corresponding chapter and go ahead.

### R graphics neglected

A third major concern is the way **R graphics** is treated in the book, because actually, we currently assume that the reader is familiar with base graphics, grid/lattice AND ggplot2. Given the stuff in the R chapter where we start with elementary concepts such as vectors and matrices, this is either unrealistic, or the R chapter can be shortened up dramatically since the audience is actually assumed to be well versed in R. The real problem is ggplot2 which AFAIK is not of widespread use yet (unless I slumbered away some major developments in the R community ...). Certainly, this produces very nice results, but is ggplot2 really necessary for the displays where it is employed? My impression is that they could have been produced either with base or grid methods as well, maybe less elegant and less decorative, but more accessible to the novice reader.

I see the following solutions:

1. Add an introduction on R graphics (base/grid/ggplot2) with the obvious risk that such a chapter can easily explode.

2. Avoid ggplot2 in the text, i.e. replace all ggplot2 code by grid or base graphics code. If the code gets too cumbersome, this might indicate the need for some new method in vcd or vcdExtra

3. Keep the ggplot2 code in the text, but also offer a grid/base graphics version in the Appendix (or the other way round).

In addition to these main issues, I have some less important, but also general comments:

### Additional remarks

* The choice of color in the displays could really be improved, and some remarks on the choice of good color palettes would be nice! Especially shading_Friendly() uses hsv colors in order to reproduce the displays in the SAS book, but this is really suboptimal.

* A package overview would be nice, either chapterwise, or in the Appendix. This could address my remark above on the guidance regarding the choice of some methods. Also, should we create a separate package index instead of integrating this in the regular index?

* Maybe, the references should be listed after each chapter? This could partly replace the "further reading" section.

* Occasionally, there are singleton sections, e.g. 2.4.1 without 2.4.2, or 5.5.1, 5.7.1, 7.4.1. ...

Remarks related to selected chapters
------------------------------------

1. The **Intro** seems very dense to me - too many important, but very different ideas in one chapter. I would suggest to avoid R code completely in this first chapter (comes in Ch2 anyway), and to remove example 1.3 (Donner party) on logistic regression, since the space shuttle example seems enough at this point (and the donner party example is quite subtle). Maybe, the description of the cases could be shortened up to the information essential for the intro, and the additional information complemented in the later chapters when they are required.

2.  **The R chapter** could give more information on aggregating and filtering data, and also editing existing data.

3. **Chapter 3** is a little bit "surprising" in a teaching context IMO. As far as I remember, fitting (discrete) distributions was not a very important topic, and maybe it should be explained why it is in the context of categorical data. Also, the first part is very elementary (list of distributions), whereas the ord plots seem very special. 

4. **Chapter 4** could mention tile plots (part of the strucplot framework), and also spine plots, maybe as a good preparation for the mosaic plots. The sieve plots are too much emphasized IMO, and maybe not a good example for the strucplot framework, not yet introduced in this chapter. The assoc plot maybe would be better for this purpose, if we really want to mention higher-dimensional tables in the chapter on 2-dim-tables, which is maybe confusing.

5. **Chapter 5** is fine, except that it actually assumes basic knowledge about loglinear models. You actually have to read it again after the last chapter on GLMs. Personally, I am having a hard time using 3D plots, and I don't think it's wise to recommend them. There is too much ugly 3D stuff around ... Also, not sure about the usefuleness of the hammock plots.

6. **Correspondence Analysis** really depends on the community - I remember that the I used more the asymmetric maps. BTW, the text states that using symmetric maps, one could compare data points from different dimensions directly, but this is not true AFAIK?

7. **Chapter 7** on logistic regression is definitely too long, as you note. We definitly need a second chapter, either in two different parts of the book, or one following the other. The diagnostic plots could be just mentioned IMO since they are repeated in the GLM chapter anyway. They seem more technical than the remainder.

8. **Chapter 8** may also deserve splitting in a basic part and a more advanced part, especially for the ordinal methods.

9. **Chapter 9** on GLMs actually should be split: the GLM stuff should come earlier, whereas the count models are a more special topic.