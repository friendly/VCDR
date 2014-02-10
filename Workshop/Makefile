# A Makefile to easily handle the compilation of
# presentations, made using the LaTeX class Beamer
#
# Patrick Pletscher
# 2006-03-05
#
# NOTE: We assume that you have a directory structure similar to
# the following:
# 
#  slides/
#    src/
#    slides.pdf
#    notes.pdf
#    handout.pdf
#
# So we copy the resulting pdf's to the parent directory.

#  latex or  pdflatex?
LATEX = latex
LATEX = pdflatex
# name of BibTeX command
BIBTEX = bibtex

# LaTeX flags
LATEXFLAGS = -interaction=nonstopmode -shell-escape
LATEXFLAGS = -interaction=nonstopmode 

# LaTeX sourcecode of slides
#SRC = carme
#SRC = datavis
SRC = vcd
INCLUDES = frames/*

# how the resulting files should be named
SLIDES_SRC = $(SRC)-slides
HANDOUT_SRC = $(SRC)-handout
NOTES_SRC = $(SRC)-notes

PDFNUP = pdfnup
NUP = --nup 2x2 --orient landscape 
NUP12 = --nup 1x2 --orient portrait 
NUP23 = --nup 2x3 --orient portrait 
NUP33 = --nup 3x3 --orient landscape 
NUP44 = --nup 4x4 --orient landscape 
NUPOPTS = --paper letterpaper --frame true --delta "2mm 2mm" --scale 0.96

# normally we just want to create the slides
short:		$(SRC).tex $(INCLUDES)
		$(LATEX) $(LATEXFLAGS) $(SRC).tex
ifeq ($(LATEX),latex)
		dvipdf $(SRC)
endif

# create slides and handouts
final:		slides handout

# create the normal slides for the presentation
slides:		$(SRC).tex $(INCLUDES)
		cp $(SRC).tex $(SLIDES_SRC).tex
		$(LATEX) $(LATEXFLAGS) $(SLIDES_SRC)
		$(LATEX) $(LATEXFLAGS) $(SLIDES_SRC)
ifeq ($(LATEX),latex)
		dvipdf $(SLIDES_SRC) 
endif
		rm -f $(SLIDES_SRC).tex
		
# create notes
notes:		$(SRC).tex $(INCLUDES)
		echo '\PassOptionsToClass{notes=only}{beamer}\input{$(SRC).tex}' > $(NOTES_SRC).tex
		$(LATEX) $(LATEXFLAGS) $(NOTES_SRC).tex
		$(LATEX) $(LATEXFLAGS) $(NOTES_SRC).tex
ifeq ($(LATEX),latex)
		dvipdf $(NOTES_SRC) 
endif
		$(LATEX) $(SRC_NOTES6UP).tex
		rm -f $(NOTES_SRC).tex 

# create handouts, for the people to print
handout:	$(SRC).tex $(INCLUDES)
		echo '\PassOptionsToClass{handout}{beamer}\input{$(SRC).tex}' > $(HANDOUT_SRC).tex
		$(LATEX) $(LATEXFLAGS) $(HANDOUT_SRC).tex
		-@egrep -c 'Citation .* undefined.' $(HANDOUT_SRC).log && ($(BIBTEX) $(HANDOUT_SRC);$(LATEX) $(HANDOUT_SRC))
		$(LATEX) $(LATEXFLAGS) $(HANDOUT_SRC).tex
ifeq ($(LATEX),latex)
		dvipdf $(HANDOUT_SRC)
endif
		pdfnup $(NUP) $(NUPOPTS) $(HANDOUT_SRC).pdf 
		rm -f $(HANDOUT_SRC).{tex,nav,log,out,snm,toc,dvi,pdf,vrb,brf,blg}


handout12:	$(SRC).tex $(INCLUDES)
		echo '\PassOptionsToClass{handout}{beamer}\input{$(SRC).tex}' > $(HANDOUT_SRC).tex
		$(LATEX) $(LATEXFLAGS) $(HANDOUT_SRC).tex
		-@egrep -c 'Citation .* undefined.' $(HANDOUT_SRC).log && ($(BIBTEX) $(HANDOUT_SRC);$(LATEX) $(HANDOUT_SRC))
		$(LATEX) $(LATEXFLAGS) $(HANDOUT_SRC).tex
ifeq ($(LATEX),latex)
		dvipdf $(HANDOUT_SRC)
endif
		pdfnup $(NUP12) $(NUPOPTS) $(HANDOUT_SRC).pdf 
		rm -f $(HANDOUT_SRC).{tex,nav,log,out,snm,toc,dvi,pdf,vrb,brf,blg}


# create handouts, for the people to print
handout23:	$(SRC).tex $(INCLUDES)
		echo '\PassOptionsToClass{handout}{beamer}\input{$(SRC).tex}' > $(HANDOUT_SRC).tex
		$(LATEX) $(LATEXFLAGS) $(HANDOUT_SRC).tex
		-@egrep -c 'Citation .* undefined.' $(HANDOUT_SRC).log && ($(BIBTEX) $(HANDOUT_SRC);$(LATEX) $(HANDOUT_SRC))
		$(LATEX) $(LATEXFLAGS) $(HANDOUT_SRC).tex
		dvipdf $(HANDOUT_SRC)
		pdfnup $(NUP23) $(NUPOPTS) $(HANDOUT_SRC).pdf 
		rm -f $(HANDOUT_SRC).{tex,nav,log,out,snm,toc,dvi,pdf,vrb,brf,blg}

# create handouts, for the people to print
handout33:	$(SRC).tex $(INCLUDES)
		echo '\PassOptionsToClass{handout}{beamer}\input{$(SRC).tex}' > $(HANDOUT_SRC).tex
		$(LATEX) $(LATEXFLAGS) $(HANDOUT_SRC).tex
		-@egrep -c 'Citation .* undefined.' $(HANDOUT_SRC).log && ($(BIBTEX) $(HANDOUT_SRC);$(LATEX) $(HANDOUT_SRC))
		$(LATEX) $(LATEXFLAGS) $(HANDOUT_SRC).tex
ifeq ($(LATEX),latex)
		dvipdf $(HANDOUT_SRC)
endif
		pdfnup $(NUP33) $(NUPOPTS) $(HANDOUT_SRC).pdf 
		rm -f $(HANDOUT_SRC).{tex,nav,log,out,snm,toc,dvi,pdf,vrb,brf,blg}

# create handouts, for the people to print
handout44:	$(SRC).tex $(INCLUDES)
		echo '\PassOptionsToClass{handout}{beamer}\input{$(SRC).tex}' > $(HANDOUT_SRC).tex
		$(LATEX) $(LATEXFLAGS) $(HANDOUT_SRC).tex
		-@egrep -c 'Citation .* undefined.' $(HANDOUT_SRC).log && ($(BIBTEX) $(HANDOUT_SRC);$(LATEX) $(HANDOUT_SRC))
		$(LATEX) $(LATEXFLAGS) $(HANDOUT_SRC).tex
ifeq ($(LATEX),latex)
		dvipdf $(HANDOUT_SRC)
endif
		pdfnup $(NUP44) $(NUPOPTS) $(HANDOUT_SRC).pdf 
		rm -f $(HANDOUT_SRC).{tex,nav,log,out,snm,toc,dvi,pdf,vrb,brf,blg}

# delete the logs
clean:		
		rm -f $(SRC).{aux,log,out,ps,toc,nav,snm,dvi,vrb,brf,blg}
