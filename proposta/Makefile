NAME = documento
TEX = $(NAME).tex
PDF = $(NAME).pdf

all: build show

build: $(TEX)
	pdflatex $(TEX)
	bibtex $(NAME)
	pdflatex $(TEX)
	bibtex $(NAME)
	pdflatex $(TEX)

show: $(PDF)
	evince $(PDF) &

clean:
	rm -rf *.aux *.idx *.log *.bbl *.blg *.ilg *.ind *.dvi *.tcp *tps

cleanall: clean
	rm -rf *.pdf *.ps
