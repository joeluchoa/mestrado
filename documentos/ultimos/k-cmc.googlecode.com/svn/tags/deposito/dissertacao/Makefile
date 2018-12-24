FORCE:

%.dvi: %.tex
	latex-mk -b --ignore-errors $*

%.ps: %.dvi
	dvips $* -o $@

%.pdf: %.ps
	ps2pdf $*.ps
 
clean:
	latex-mk --clean mestrado.tex
	rm -f *.brf *.lof *.dvi *.ps *.aux *.scn *.log *.toc *.idx *.out *.ilg *.ind *.tgz *.blg *.bbl *.old
	rm -rf mestrado
	rm -f mestrado.pdf

%.html: %.dvi
	latex2html -html_version 4.0 -no_navigation -info 0 -split 0 -local_icons -white -no_footnode mestrado.tex 	
	cat estilo.css >> mestrado/mestrado.css
	
all: mestrado.ps mestrado.pdf mestrado.html

dist: mestrado.html mestrado.pdf
	cat estilo.css >> mestrado/mestrado.css
	
#tar czvf tudo.tgz mestrado mestrado.pdf index.html apresentacao.ppt MAC499\ -\ Proposta\ de\ mestrado.html  
