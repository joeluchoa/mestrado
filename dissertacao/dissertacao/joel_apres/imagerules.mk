# General rules for making images

%.pdf: %.eps
	epstopdf $< > $@

%.eps: %.dot
	- dot -Teps < $< > $@

%.pdf: %.svg
	inkscape -A $@ $<

%.eps: %.plt
	gnuplot $< > $@

%.eps: %.dia
	dia -e $@ -t eps $<

%.eps: %.png
	png2eps $< > $@
