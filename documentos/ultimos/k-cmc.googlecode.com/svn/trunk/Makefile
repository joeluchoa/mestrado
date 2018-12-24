%.pdf: %.ps
	ps2pdf $*.ps
 
%.dvi: %.tex
	latex-mk -b --ignore-errors $*

FORCE:

%.ps: %.dvi
	dvips $* -o $@

clean:
	latex-mk --clean projeto.tex
	rm -f *.dvi *.ps *.aux *.scn *.log *.toc *.idx *.out *.ilg *.ind *.tgz *.blg *.bbl *.old
	rm -rf projeto
	rm -f projeto.pdf

%.html: %.dvi
	latex2html -html_version 4.0 -no_navigation -info 0 -split 0 -local_icons -white -no_footnode projeto.tex 	
	cat estilo.css >> projeto/projeto.css
	
all: projeto.ps projeto.pdf projeto.html

dist: projeto.html projeto.pdf
	cat estilo.css >> projeto/projeto.css
	
#tar czvf tudo.tgz projeto projeto.pdf index.html apresentacao.ppt MAC499\ -\ Proposta\ de\ projeto.html  
