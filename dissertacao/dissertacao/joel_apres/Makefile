include imagerules.mk

filename=joel_pres
DEPS=macros.sty

%.pdf: %.tex
	pdflatex $<
	pdflatex $<
	bibtex $*
	pdflatex $<
	pdflatex $<

all: pdf

pdf: $(filename).pdf

$(filename).pdf: $(DEPS)

preview: $(filename).pdf
	evince $(filename).pdf

clean:
	rm -f $(filename).aux $(filename).log $(filename).out $(filename).pdf \
	      $(filename).bbl $(filename).blg $(filename).nav $(filename).snm \
	      $(filename).toc $(GENFIGS)
