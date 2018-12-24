#Makefile

SGBDIR = ./sgb
INCLUDEDIR = -I$(SGBDIR)/include -I./dimacs
LIBDIR = ./sgb/lib
CWEBINPUTS = $(SGBDIR)/lib/cweb

#Compilador
CC = gcc

#   If you prefer optimization to debugging, change -g to something like -O:
CFLAGS = -g -Wall -pedantic -ansi -O3 -pg $(INCLUDEDIR)
#CFLAGS = -g -Wall -pedantic -ansi -O3 $(INCLUDEDIR)

LDFLAGS = -L. -L$(LIBDIR)
LDLIBS = -lgb -lm
LOADLIBS = $(LDLIBS)

CAPITULOS = 01-conceitos.w 02-problema.w 03-dijkstra.w 04-heap.w \
	05-dinitz.w 06-thorup.w 07-resultados.w 08-conclusoes.w \
	ap-implementacoes.w mestrado.w
TEX = latex
BIB = bibtex
INDEX = makeindex
RM = rm

#############################################################################
# Testes
# Geradores de grafos
GERADORES = ./geradores/bin
RAND = $(GERADORES)/sprand
GRID = $(GERADORES)/spgrid
BAD = $(GERADORES)/spbad

#
MEM = ./mem/memtime

# upper bound
MAX = 10000
# lower bound
MIN = 1

#parametros
RAND_SPARSE = -cl$(MAX) -lm$(MIN) -ll$(MAX)
RAND_DENSE = -cl$(MAX) -lm$(MIN) -ll$(MAX)
#GRID_SWIDE =  -cm$(MIN) -cl$(MAX) -im1000 -il$(MAX)
#GRID_SLONG = -cm$(MIN) -cl$(MAX) -im1000 -il$(MAX)
GRID_SWIDE =  -cm$(MIN) -cl$(MAX) -im$(MIN) -il$(MAX)
GRID_SLONG = -cm$(MIN) -cl$(MAX) -im$(MIN) -il$(MAX)

# Saida
RESULT = ./geradores/resultados

# Programas
EXE = programa
HEAP = heap
DHEAP = dheap
FHEAP = fheap
BHEAP = bheap
RHEAP = rheap
THORUP= thorup

# Script para calcular as médias 
CALC_MEDIA = ./graficos/calcula_medias.pl tempos.txt
CALC_MEMS = ./graficos/calcula_medias.pl mems.txt
CALC_MEDIA_FP = ./graficos/calcula_mediafp.pl potencial.txt
###########################################################################
all: dissertacao ps

dissertacao: mestrado.bbl
	- $(TEX) mestrado.tex
	- $(TEX) mestrado.tex

mestrado.bbl: mestrado.aux
	- $(BIB) mestrado
	- $(INDEX) mestrado

mestrado.aux: mestrado.tex
	- $(TEX) mestrado.tex

mestrado.tex : $(CAPITULOS)
	cweave +e mestrado

mestrado.c: 01-conceitos.w 02-problema.w 03-dijkstra.w 04-heap.w 05-dinitz.w 06-thorup.w 07-resultados.w 08-conclusoes.w ap-implementacoes.w mestrado.w
	ctangle mestrado.w

programa: mestrado.c
	$(CC) $(CFLAGS) $(LDFLAGS)  -o programa mestrado.c $(LOADLIBS) 

ps:
	dvips mestrado.dvi -o mestrado.ps

###################################################################################
#  Testes
#
# sprand_sparso: grafos randômicos onde m = 4n (está 2n pq ainda vou criar arestas)
# sprand_denso: grafos randômicos onde m = n^2/4
# spgrid : grafos tipo grade
# spbad: 
#
###################################################################################
testes: sprand_esparso sprand_denso spgrid_wide spgrid_long mem_testes
#spbad_esparso spbad_denso

sprand_esparso:
	echo > medias.txt
	echo > mediasfp.txt
	$(RAND) 8192 16384 561 $(RAND_SPARSE)  | $(EXE) > $(RESULT)/re.8192.1
	$(RAND) 8192 16384 563 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.8192.2
	$(RAND) 8192 16384 565 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.8192.3
	$(RAND) 8192 16384 567 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.8192.4
	$(RAND) 8192 16384 569 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.8192.5
	$(CALC_MEDIA) 5 8192
	$(CALC_MEDIA_FP) 5 8192
	mv potencial.txt $(RESULT)/fpre.8192
	mv tempos.txt $(RESULT)/tre.8192

	$(RAND) 16384 32768 661 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.16384.1
	$(RAND) 16384 32768 663 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.16384.2
	$(RAND) 16384 32768 665 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.16384.3
	$(RAND) 16384 32768 667 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.16384.4
	$(RAND) 16384 32768 669 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.16384.5
	$(CALC_MEDIA) 5 16384
	$(CALC_MEDIA_FP) 5 16384
	mv potencial.txt $(RESULT)/fpre.16384
	mv tempos.txt $(RESULT)/tre.16384

	$(RAND) 32768 65536 761 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.32768.1
	$(RAND) 32768 65536 763 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.32768.2
	$(RAND) 32768 65536 765 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.32768.3
	$(RAND) 32768 65536 767 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.32768.4
	$(RAND) 32768 65536 769 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.32768.5
	$(CALC_MEDIA) 5 32768
	$(CALC_MEDIA_FP) 5 32768
	mv potencial.txt $(RESULT)/fpre.32768
	mv tempos.txt $(RESULT)/tre.32768

	$(RAND) 65536 131072 861 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.65536.1
	$(RAND) 65536 131072 863 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.65536.2
	$(RAND) 65536 131072 865 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.65536.3
	$(RAND) 65536 131072 867 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.65536.4
	$(RAND) 65536 131072 869 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.65536.5
	$(CALC_MEDIA) 5 65536
	$(CALC_MEDIA_FP) 5 65536
	mv potencial.txt $(RESULT)/fpre.65536
	mv tempos.txt $(RESULT)/tre.65536

	$(RAND) 131072 262144 961 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.131072.1
	$(RAND) 131072 262144 963 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.131072.2
	$(RAND) 131072 262144 965 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.131072.3
	$(RAND) 131072 262144 967 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.131072.4
	$(RAND) 131072 262144 969 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.131072.5
	$(CALC_MEDIA) 5 131072
	$(CALC_MEDIA_FP) 5 131072
	mv potencial.txt $(RESULT)/fpre.131072
	mv tempos.txt $(RESULT)/tre.131072

	$(RAND) 262144 524288 361 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.262144.1
	$(RAND) 262144 524288 363 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.262144.2
	$(RAND) 262144 524288 365 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.262144.3
	$(RAND) 262144 524288 367 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.262144.4
	$(RAND) 262144 524288 369 $(RAND_SPARSE) | $(EXE) > $(RESULT)/re.262144.5
	$(CALC_MEDIA) 5 262144
	$(CALC_MEDIA_FP) 5 262144
	mv potencial.txt $(RESULT)/fpre.262144
	mv tempos.txt $(RESULT)/tre.262144

	mv medias.txt trand_esparso_$(MAX).txt
	mv trand_esparso_$(MAX).txt ./graficos
	mv mediasfp.txt fprand_esparso_$(MAX).txt
	mv fprand_esparso_$(MAX).txt ./graficos

sprand_denso:
	echo > medias.txt
	echo > mediasfp.txt
	$(RAND) 512 32768 251 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.512.1
	$(RAND) 512 32768 253 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.512.2
	$(RAND) 512 32768 255 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.512.3
	$(RAND) 512 32768 257 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.512.4
	$(RAND) 512 32768 259 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.512.5
	$(CALC_MEDIA) 5 512
	$(CALC_MEDIA_FP) 5 512
	mv potencial.txt $(RESULT)/fprd.512
	mv tempos.txt $(RESULT)/trd.512

	$(RAND) 1024 131072 351 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.1024.1
	$(RAND) 1024 131072 353 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.1024.2
	$(RAND) 1024 131072 355 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.1024.3
	$(RAND) 1024 131072 357 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.1024.4
	$(RAND) 1024 131072 359 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.1024.5
	$(CALC_MEDIA) 5 1024
	$(CALC_MEDIA_FP) 5 1024
	mv potencial.txt $(RESULT)/fprd.1024
	mv tempos.txt $(RESULT)/trd.1024

	$(RAND) 2048 524288 451 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.2048.1
	$(RAND) 2048 524288 453 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.2048.2
	$(RAND) 2048 524288 455 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.2048.3
	$(RAND) 2048 524288 457 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.2048.4
	$(RAND) 2048 524288 459 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.2048.5
	$(CALC_MEDIA) 5 2048 
	$(CALC_MEDIA_FP) 5 2048
	mv potencial.txt $(RESULT)/fprd.2048
	mv tempos.txt $(RESULT)/trd.2048

	$(RAND) 4096 2097152 551 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.4096.1
	$(RAND) 4096 2097152 553 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.4096.2
	$(RAND) 4096 2097152 555 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.4096.3
	$(RAND) 4096 2097152 557 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.4096.4
	$(RAND) 4096 2097152 559 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.4096.5
	$(CALC_MEDIA) 5 4096
	$(CALC_MEDIA_FP) 5 4096
	mv potencial.txt $(RESULT)/fprd.4096
	mv tempos.txt $(RESULT)/trd.4096

	$(RAND) 8192 8388608 751 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.8192.1
	$(RAND) 8192 8388608 753 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.8192.2
	$(RAND) 8192 8388608 755 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.8192.3
	$(RAND) 8192 8388608 757 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.8192.4
	$(RAND) 8192 8388608 759 $(RAND_DENSE) | $(EXE) > $(RESULT)/rd.8192.5
	$(CALC_MEDIA) 5 8192
	$(CALC_MEDIA_FP) 5 8192
	mv potencial.txt $(RESULT)/fprd.8192
	mv tempos.txt $(RESULT)/trd.8192

	mv medias.txt trand_denso_$(MAX).txt
	mv trand_denso_$(MAX).txt ./graficos
	mv mediasfp.txt fprand_denso_$(MAX).txt
	mv fprand_denso_$(MAX).txt ./graficos
spgrid_wide:
	echo > medias.txt
	echo > mediasfp.txt
	$(GRID) 16 512 281 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.512x16.1
	$(GRID) 16 512 283 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.512x16.2
	$(GRID) 16 512 285 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.512x16.3
	$(GRID) 16 512 287 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.512x16.4
	$(GRID) 16 512 289 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.512x16.5
	$(CALC_MEDIA) 5 512
	$(CALC_MEDIA_FP) 5 512
	mv potencial.txt $(RESULT)/fpgw.512
	mv tempos.txt $(RESULT)/tgw.512

	$(GRID) 16 1024 381 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.1024x16.1
	$(GRID) 16 1024 383 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.1024x16.2
	$(GRID) 16 1024 385 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.1024x16.3
	$(GRID) 16 1024 387 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.1024x16.4
	$(GRID) 16 1024 389 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.1024x16.5
	$(CALC_MEDIA) 5 1024
	$(CALC_MEDIA_FP) 5 1024
	mv potencial.txt $(RESULT)/fpgw.1024
	mv tempos.txt $(RESULT)/tgw.1024

	$(GRID) 16 2048 481 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.2048x16.1
	$(GRID) 16 2048 483 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.2048x16.2
	$(GRID) 16 2048 485 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.2048x16.3
	$(GRID) 16 2048 487 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.2048x16.4
	$(GRID) 16 2048 489 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.2048x16.5
	$(CALC_MEDIA) 5 2048
	$(CALC_MEDIA_FP) 5 2048
	mv potencial.txt $(RESULT)/fpgw.2048
	mv tempos.txt $(RESULT)/tgw.2048

	$(GRID) 16 4096 581 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.4096x16.1
	$(GRID) 16 4096 583 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.4096x16.2
	$(GRID) 16 4096 585 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.4096x16.3
	$(GRID) 16 4096 587 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.4096x16.4
	$(GRID) 16 4096 589 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.4096x16.5
	$(CALC_MEDIA) 5 4096
	$(CALC_MEDIA_FP) 5 4096
	mv potencial.txt $(RESULT)/fpgw.4096
	mv tempos.txt $(RESULT)/tgw.4096

	$(GRID) 16 8192 681 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.8192x16.1
	$(GRID) 16 8192 683 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.8192x16.2
	$(GRID) 16 8192 685 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.8192x16.3
	$(GRID) 16 8192 687 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.8192x16.4
	$(GRID) 16 8192 689 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.8192x16.5
	$(CALC_MEDIA) 5 8192
	$(CALC_MEDIA_FP) 5 8192
	mv potencial.txt $(RESULT)/fpgw.8192
	mv tempos.txt $(RESULT)/tgw.8192

	$(GRID) 16 16384 781 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.16384x16.1
	$(GRID) 16 16384 783 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.16384x16.2
	$(GRID) 16 16384 785 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.16384x16.3
	$(GRID) 16 16384 787 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.16384x16.4
	$(GRID) 16 16384 789 $(GRID_SWIDE) | $(EXE) > $(RESULT)/gw.16384x16.5
	$(CALC_MEDIA) 5 16384
	$(CALC_MEDIA_FP) 5 16384
	mv potencial.txt $(RESULT)/fpgw.16384
	mv tempos.txt $(RESULT)/tgw.16384

	mv medias.txt tgrid_wide_$(MAX).txt
	mv tgrid_wide_$(MAX).txt ./graficos
	mv mediasfp.txt fpgrid_wide_$(MAX).txt
	mv fpgrid_wide_$(MAX).txt ./graficos
spgrid_long:
	echo > medias.txt
	echo > mediasfp.txt
	$(GRID) 512  16 281 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.512x16.1
	$(GRID) 512  16 283 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.512x16.2
	$(GRID) 512  16 285 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.512x16.3
	$(GRID) 512  16 287 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.512x16.4
	$(GRID) 512  16 289 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.512x16.5
	$(CALC_MEDIA) 5 512
	$(CALC_MEDIA_FP) 5 512
	mv potencial.txt $(RESULT)/fpgl.512
	mv tempos.txt $(RESULT)/tgl.512

	$(GRID) 1024 16 381 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.1024x16.1
	$(GRID) 1024 16 383 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.1024x16.2
	$(GRID) 1024 16 385 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.1024x16.3
	$(GRID) 1024 16 387 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.1024x16.4
	$(GRID) 1024 16 389 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.1024x16.5
	$(CALC_MEDIA) 5 1024
	$(CALC_MEDIA_FP) 5 1024
	mv potencial.txt $(RESULT)/fpgl.1024
	mv tempos.txt $(RESULT)/tgl.1024

	$(GRID) 2048 16 481 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.2048x16.1
	$(GRID) 2048 16 483 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.2048x16.2
	$(GRID) 2048 16 485 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.2048x16.3
	$(GRID) 2048 16 487 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.2048x16.4
	$(GRID) 2048 16 489 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.2048x16.5
	$(CALC_MEDIA) 5 2048
	$(CALC_MEDIA_FP) 5 2048
	mv potencial.txt $(RESULT)/fpgl.2048
	mv tempos.txt $(RESULT)/tgl.2048

	$(GRID) 4096 16 581 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.4096x16.1
	$(GRID) 4096 16 583 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.4096x16.2
	$(GRID) 4096 16 585 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.4096x16.3
	$(GRID) 4096 16 587 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.4096x16.4
	$(GRID) 4096 16 589 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.4096x16.5
	$(CALC_MEDIA) 5 4096
	$(CALC_MEDIA_FP) 5 4096
	mv potencial.txt $(RESULT)/fpgl.4096
	mv tempos.txt $(RESULT)/tgl.4096

	$(GRID) 8192 16 681 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.8192x16.1
	$(GRID) 8192 16 683 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.8192x16.2
	$(GRID) 8192 16 685 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.8192x16.3
	$(GRID) 8192 16 687 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.8192x16.4
	$(GRID) 8192 16 689 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.8192x16.5
	$(CALC_MEDIA) 5 8192
	$(CALC_MEDIA_FP) 5 8192
	mv potencial.txt $(RESULT)/fpgl.8192
	mv tempos.txt $(RESULT)/tgl.8192

	$(GRID) 16384 16 781 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.16384x16.1
	$(GRID) 16384 16 783 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.16384x16.2
	$(GRID) 16384 16 785 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.16384x16.3
	$(GRID) 16384 16 787 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.16384x16.4
	$(GRID) 16384 16 789 $(GRID_SLONG) | $(EXE) > $(RESULT)/gl.16384x16.5
	$(CALC_MEDIA) 5 16384
	$(CALC_MEDIA_FP) 5 16384
	mv potencial.txt $(RESULT)/fpgl.16384
	mv tempos.txt $(RESULT)/tgl.16384

	mv medias.txt tgrid_long_$(MAX).txt
	mv tgrid_long_$(MAX).txt ./graficos
	mv mediasfp.txt fpgrid_long_$(MAX).txt
	mv fpgrid_long_$(MAX).txt ./graficos
spbad_esparso:
	echo > medias.txt
	echo > mediasfp.txt
	$(BAD) 512 10 -s39011  | $(EXE) > $(RESULT)/bade.512.1
	$(BAD) 512 10 -s39012 | $(EXE) > $(RESULT)/bade.512.2
	$(BAD) 512 10 -s39013 | $(EXE) > $(RESULT)/bade.512.3
	$(BAD) 512 10 -s39014 | $(EXE) > $(RESULT)/bade.512.4
	$(BAD) 512 10 -s39015 | $(EXE) > $(RESULT)/bade.512.5
	$(CALC_MEDIA) 5 512
	$(CALC_MEDIA_FP) 5 512
	mv potencial.txt $(RESULT)/fpbade.512
	mv tempos.txt $(RESULT)/tbade.512

	$(BAD) 1024 10 -s39016 | $(EXE) > $(RESULT)/bade.1024.1
	$(BAD) 1024 10 -s39017 | $(EXE) > $(RESULT)/bade.1024.2
	$(BAD) 1024 10 -s39017 | $(EXE) > $(RESULT)/bade.1024.3
	$(BAD) 1024 10 -s39018 | $(EXE) > $(RESULT)/bade.1024.4
	$(BAD) 1024 10 -s39019 | $(EXE) > $(RESULT)/bade.1024.5
	$(CALC_MEDIA) 5 1024
	$(CALC_MEDIA_FP) 5 1024
	mv potencial.txt $(RESULT)/fpbade.1024
	mv tempos.txt $(RESULT)/tbade.1024

	$(BAD) 2048 10 -s39020 | $(EXE) > $(RESULT)/bade.2048.1
	$(BAD) 2048 10 -s39021 | $(EXE) > $(RESULT)/bade.2048.2
	$(BAD) 2048 10 -s39022 | $(EXE) > $(RESULT)/bade.2048.3
	$(BAD) 2048 10 -s39023 | $(EXE) > $(RESULT)/bade.2048.4
	$(BAD) 2048 10 -s39024 | $(EXE) > $(RESULT)/bade.2048.5
	$(CALC_MEDIA) 5 2048
	$(CALC_MEDIA_FP) 5 2048
	mv potencial.txt $(RESULT)/fpbade.2048
	mv tempos.txt $(RESULT)/tbade.2048

	$(BAD) 4096 10 -s39025 | $(EXE) > $(RESULT)/bade.4096.1
	$(BAD) 4096 10 -s39026 | $(EXE) > $(RESULT)/bade.4096.2
	$(BAD) 4096 10 -s39027 | $(EXE) > $(RESULT)/bade.4096.3
	$(BAD) 4096 10 -s39028 | $(EXE) > $(RESULT)/bade.4096.4
	$(BAD) 4096 10 -s39029 | $(EXE) > $(RESULT)/bade.4096.5
	$(CALC_MEDIA) 5 4096
	$(CALC_MEDIA_FP) 5 4096
	mv potencial.txt $(RESULT)/fpbade.4096
	mv tempos.txt $(RESULT)/tbade.4096

	$(BAD) 8192 10 -s39030 | $(EXE) > $(RESULT)/bade.8192.1
	$(BAD) 8192 10 -s39031 | $(EXE) > $(RESULT)/bade.8192.2
	$(BAD) 8192 10 -s39032 | $(EXE) > $(RESULT)/bade.8192.3
	$(BAD) 8192 10 -s39033 | $(EXE) > $(RESULT)/bade.8192.4
	$(BAD) 8192 10 -s39034 | $(EXE) > $(RESULT)/bade.8192.5
	$(CALC_MEDIA) 5 8192
	$(CALC_MEDIA_FP) 5 8192
	mv potencial.txt $(RESULT)/fpbade.8192
	mv tempos.txt $(RESULT)/tbade.8192

	mv medias.txt tbad_esparso.txt
	mv tbad_esparso.txt ./graficos
	mv mediasfp.txt fpbad_esparso.txt
	mv fpbad_esparso.txt ./graficos
spbad_denso:
	echo > medias.txt
	echo > mediasfp.txt
	$(BAD) 512 64 -s39011  | $(EXE) > $(RESULT)/badd.512.2.1
	$(BAD) 512 64 -s39012 | $(EXE) > $(RESULT)/badd.512.2.2
	$(BAD) 512 64 -s39013 | $(EXE) > $(RESULT)/badd.512.2.3
	$(BAD) 512 64 -s39014 | $(EXE) > $(RESULT)/badd.512.2.4
	$(BAD) 512 64 -s39015 | $(EXE) > $(RESULT)/badd.512.2.5
	$(CALC_MEDIA) 5 512
	$(CALC_MEDIA_FP) 5 512	
	mv potencial.txt $(RESULT)/fpbadd.512
	mv tempos.txt $(RESULT)/tbadd.512

	$(BAD) 1024 128 -s39016 | $(EXE) > $(RESULT)/badd.1024.2.1
	$(BAD) 1024 128 -s39017 | $(EXE) > $(RESULT)/badd.1024.2.2
	$(BAD) 1024 128 -s39017 | $(EXE) > $(RESULT)/badd.1024.2.3
	$(BAD) 1024 128 -s39018 | $(EXE) > $(RESULT)/badd.1024.2.4
	$(BAD) 1024 128 -s39019 | $(EXE) > $(RESULT)/badd.1024.2.5
	$(CALC_MEDIA) 5 1024
	$(CALC_MEDIA_FP) 5 1024	
	mv potencial.txt $(RESULT)/fpbadd.1024
	mv tempos.txt $(RESULT)/tbadd.1024

	$(BAD) 2048 256 -s39020 | $(EXE) > $(RESULT)/badd.2048.2.1
	$(BAD) 2048 256 -s39021 | $(EXE) > $(RESULT)/badd.2048.2.2
	$(BAD) 2048 256 -s39022 | $(EXE) > $(RESULT)/badd.2048.2.3
	$(BAD) 2048 256 -s39023 | $(EXE) > $(RESULT)/badd.2048.2.4
	$(BAD) 2048 256 -s39024 | $(EXE) > $(RESULT)/badd.2048.2.5
	$(CALC_MEDIA) 5 2048
	$(CALC_MEDIA_FP) 5 2048	
	mv potencial.txt $(RESULT)/fpbadd.2048
	mv tempos.txt $(RESULT)/tbadd.2048

	$(BAD) 4096 512 -s39025 | $(EXE) > $(RESULT)/badd.4096.1
	$(BAD) 4096 512 -s39026 | $(EXE) > $(RESULT)/badd.4096.2
	$(BAD) 4096 512 -s39027 | $(EXE) > $(RESULT)/badd.4096.3
	$(BAD) 4096 512 -s39028 | $(EXE) > $(RESULT)/badd.4096.4
	$(BAD) 4096 512 -s39029 | $(EXE) > $(RESULT)/badd.4096.5
	$(CALC_MEDIA) 5 4096
	$(CALC_MEDIA_FP) 5 4096
	mv potencial.txt $(RESULT)/fpbadd.4096
	mv tempos.txt $(RESULT)/tbadd.4096

	$(BAD) 8192 1024 -s39030 | $(EXE) > $(RESULT)/badd.8192.1
	$(BAD) 8192 1024 -s39031 | $(EXE) > $(RESULT)/badd.8192.2
	$(BAD) 8192 1024 -s39032 | $(EXE) > $(RESULT)/badd.8192.3
	$(BAD) 8192 1024 -s39033 | $(EXE) > $(RESULT)/badd.8192.4
	$(BAD) 8192 1024 -s39034 | $(EXE) > $(RESULT)/badd.8192.5
	$(CALC_MEDIA) 5 8192
	$(CALC_MEDIA_FP) 5 8192	
	mv potencial.txt $(RESULT)/fpbadd.8192
	mv tempos.txt $(RESULT)/tbadd.8192

	mv medias.txt tbad_denso.txt
	mv tbad_denso.txt ./graficos
	mv mediasfp.txt fpbad_denso.txt
	mv fpbad_denso.txt ./graficos
####################################################################################
# estimativa do uso de memória

mem_testes: PROGS HEAP DHEAP FHEAP BHEAP RHEAP THORUP

PROGS:
	$(CC) $(CFLAGS) $(LDFLAGS)  -o heap heap.c $(LOADLIBS)
	$(CC) $(CFLAGS) $(LDFLAGS)  -o dheap dheap.c $(LOADLIBS) 
	$(CC) $(CFLAGS) $(LDFLAGS)  -o fheap fheap.c $(LOADLIBS)  
	$(CC) $(CFLAGS) $(LDFLAGS)  -o bheap bheap.c $(LOADLIBS) 
	$(CC) $(CFLAGS) $(LDFLAGS)  -o rheap rheap.c $(LOADLIBS) 
	$(CC) $(CFLAGS) $(LDFLAGS)  -o thorup thorup.c $(LOADLIBS) 

# TESTA MEMÓRIA USANDO HEAP
HEAP: 
#sprand_esparso
	echo > medias.txt
	$(RAND) 8192 16384 561 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 8192 16384 563 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 8192 16384 565 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 8192 16384 567 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 8192 16384 569 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/heap_rand_esparso_$(MAX).8192

	$(RAND) 16384 32768 661 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 16384 32768 663 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 16384 32768 665 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 16384 32768 667 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 16384 32768 669 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(CALC_MEMS) 5 16384
	mv mems.txt $(RESULT)/heap_rand_esparso_$(MAX).16384

	$(RAND) 32768 65536 761 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 32768 65536 763 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 32768 65536 765 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 32768 65536 767 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 32768 65536 769 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(CALC_MEMS) 5 32768
	mv mems.txt $(RESULT)/heap_rand_esparso_$(MAX).32768

	$(RAND) 65536 131072 861 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 65536 131072 863 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 65536 131072 865 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 65536 131072 867 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 65536 131072 869 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(CALC_MEMS) 5 65536
	mv mems.txt $(RESULT)/heap_rand_esparso_$(MAX).65536

	$(RAND) 131072 262144 961 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 131072 262144 963 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 131072 262144 965 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 131072 262144 967 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(RAND) 131072 262144 969 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(CALC_MEMS) 5 131072
	mv mems.txt $(RESULT)/heap_rand_esparso_$(MAX).131072

	$(RAND) 262144 524288 361 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 262144 524288 363 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 262144 524288 365 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 262144 524288 367 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(RAND) 262144 524288 369 $(RAND_SPARSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(CALC_MEMS) 5 262144
	mv mems.txt $(RESULT)/heap_rand_esparso_$(MAX).262144

	mv medias.txt mems_heap_rand_esparso_$(MAX).txt
	mv mems_heap_rand_esparso_$(MAX).txt ./graficos

#sprand_denso
	echo > medias.txt
	$(RAND) 512 32768 251 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(RAND) 512 32768 253 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(RAND) 512 32768 255 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(RAND) 512 32768 257 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(RAND) 512 32768 259 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/heap_rand_denso_$(MAX).512

	$(RAND) 1024 131072 351 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(RAND) 1024 131072 353 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(RAND) 1024 131072 355 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(RAND) 1024 131072 357 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(RAND) 1024 131072 359 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/heap_rand_denso_$(MAX).1024

	$(RAND) 2048 524288 451 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(RAND) 2048 524288 453 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(RAND) 2048 524288 455 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(RAND) 2048 524288 457 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(RAND) 2048 524288 459 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 2048 
	mv mems.txt $(RESULT)/heap_rand_denso_$(MAX).2048

	$(RAND) 4096 2097152 551 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(RAND) 4096 2097152 553 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(RAND) 4096 2097152 555 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(RAND) 4096 2097152 557 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(RAND) 4096 2097152 559 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/heap_rand_denso_$(MAX).4096

	$(RAND) 8192 8388608 751 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(RAND) 8192 8388608 753 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(RAND) 8192 8388608 755 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(RAND) 8192 8388608 757 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(RAND) 8192 8388608 759 $(RAND_DENSE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/heap_rand_denso_$(MAX).8192
	mv medias.txt mems_heap_rand_denso_$(MAX).txt
	mv mems_heap_rand_denso_$(MAX).txt ./graficos

#spgrid_wide
	echo > medias.txt
	$(GRID) 16 512 281 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 512 283 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 512 285 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 512 287 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 512 289 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/heap_grid_wide_$(MAX).512

	$(GRID) 16 1024 381 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 1024 383 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 1024 385 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 1024 387 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 1024 389 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/heap_grid_wide_$(MAX).1024

	$(GRID) 16 2048 481 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 2048 483 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 2048 485 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 2048 487 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 2048 489 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/heap_grid_wide_$(MAX).2048

	$(GRID) 16 4096 581 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 4096 583 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 4096 585 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 4096 587 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 4096 589 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/heap_grid_wide_$(MAX).4096

	$(GRID) 16 8192 681 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 8192 683 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 8192 685 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 8192 687 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 8192 689 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/heap_grid_wide_$(MAX).8192

	$(GRID) 16 16384 781 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 16384 783 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16 16384 785 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(GRID) 16 16384 787 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(GRID) 16 16384 789 $(GRID_SWIDE) | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(CALC_MEMS) 5 16384
	mv mems.txt $(RESULT)/heap_grid_wide_$(MAX).16384
	mv medias.txt mems_heap_grid_wide_$(MAX).txt
	mv mems_heap_grid_wide_$(MAX).txt ./graficos
#spgrid_long:
	echo > medias.txt
	$(GRID) 512  16 281 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 512  16 283 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 512  16 285 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 512  16 287 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 512  16 289 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/heap_grid_long_$(MAX).512

	$(GRID) 1024 16 381 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 1024 16 383 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 1024 16 385 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 1024 16 387 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 1024 16 389 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/heap_grid_long_$(MAX).1024

	$(GRID) 2048 16 481 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 2048 16 483 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 2048 16 485 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 2048 16 487 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 2048 16 489 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/heap_grid_long_$(MAX).2048

	$(GRID) 4096 16 581 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 4096 16 583 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 4096 16 585 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 4096 16 587 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 4096 16 589 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/heap_grid_long_$(MAX).4096

	$(GRID) 8192 16 681 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 8192 16 683 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 8192 16 685 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 8192 16 687 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 8192 16 689 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/heap_grid_long_$(MAX).8192

	$(GRID) 16384 16 781 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16384 16 783 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16384 16 785 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16384 16 787 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(GRID) 16384 16 789 $(GRID_SLONG) | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 16384
	mv mems.txt $(RESULT)/heap_grid_long_$(MAX).16384
	mv medias.txt mems_heap_grid_long_$(MAX).txt
	mv mems_heap_grid_long_$(MAX).txt ./graficos

#spbad_esparso
NAO_FAZ1:
	echo > medias.txt
	$(BAD) 512 10 -s39011  | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(BAD) 512 10 -s39012 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 512 10 -s39013 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 512 10 -s39014 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 512 10 -s39015 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/heap_bad_esparso.512

	$(BAD) 1024 10 -s39016 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 1024 10 -s39017 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 1024 10 -s39017 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 1024 10 -s39018 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 1024 10 -s39019 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/heap_bad_esparso.1024

	$(BAD) 2048 10 -s39020 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 2048 10 -s39021 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 2048 10 -s39022 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 2048 10 -s39023 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 2048 10 -s39024 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/heap_bad_esparso.2048

	$(BAD) 4096 10 -s39025 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 4096 10 -s39026 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 4096 10 -s39027 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 4096 10 -s39028 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 4096 10 -s39029 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/heap_bad_esparso.4096

	$(BAD) 8192 10 -s39030 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 8192 10 -s39031 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 8192 10 -s39032 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 8192 10 -s39033 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 8192 10 -s39034 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/heap_bad_esparso.8192
	mv medias.txt mems_heap_bad_esparso.txt
	mv mems_heap_bad_esparso.txt ./graficos

#spbad_denso
	echo > medias.txt
	$(BAD) 512 64 -s39011  | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 512 64 -s39012 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 512 64 -s39013 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 512 64 -s39014 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 512 64 -s39015 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/heap_bad_denso.512

	$(BAD) 1024 128 -s39016 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 1024 128 -s39017 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 1024 128 -s39017 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 1024 128 -s39018 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 1024 128 -s39019 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/heap_bad_denso.1024

	$(BAD) 2048 256 -s39020 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 2048 256 -s39021 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 2048 256 -s39022 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 2048 256 -s39023 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 2048 256 -s39024 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/heap_bad_denso.2048

	$(BAD) 4096 512 -s39025 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 4096 512 -s39026 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 4096 512 -s39027 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 4096 512 -s39028 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(BAD) 4096 512 -s39029 | $(MEM) $(HEAP) >> heap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/heap_bad_denso.4096

	$(BAD) 8192 1024 -s39030 | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(BAD) 8192 1024 -s39031 | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(BAD) 8192 1024 -s39032 | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(BAD) 8192 1024 -s39033 | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(BAD) 8192 1024 -s39034 | $(MEM) $(HEAP) >> heap_$(MAX).mem
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/heap_bad_denso.8192
	mv medias.txt mems_heap_bad_denso.txt
	mv mems_heap_bad_denso.txt ./graficos


# TESTA MEMÓRIA USANDO DHEAP

DHEAP: 
#sprand_esparso
	echo > medias.txt
	$(RAND) 8192 16384 561 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 8192 16384 563 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 8192 16384 565 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 8192 16384 567 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 8192 16384 569 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/dheap_rand_esparso_$(MAX).8192

	$(RAND) 16384 32768 661 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 16384 32768 663 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 16384 32768 665 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 16384 32768 667 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 16384 32768 669 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(CALC_MEMS) 5 16384
	mv mems.txt $(RESULT)/dheap_rand_esparso_$(MAX).16384

	$(RAND) 32768 65536 761 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 32768 65536 763 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 32768 65536 765 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 32768 65536 767 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 32768 65536 769 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(CALC_MEMS) 5 32768
	mv mems.txt $(RESULT)/dheap_rand_esparso_$(MAX).32768

	$(RAND) 65536 131072 861 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 65536 131072 863 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 65536 131072 865 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 65536 131072 867 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 65536 131072 869 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(CALC_MEMS) 5 65536
	mv mems.txt $(RESULT)/dheap_rand_esparso_$(MAX).65536

	$(RAND) 131072 262144 961 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 131072 262144 963 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 131072 262144 965 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 131072 262144 967 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(RAND) 131072 262144 969 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(CALC_MEMS) 5 131072
	mv mems.txt $(RESULT)/dheap_rand_esparso_$(MAX).131072

	$(RAND) 262144 524288 361 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 262144 524288 363 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 262144 524288 365 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 262144 524288 367 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(RAND) 262144 524288 369 $(RAND_SPARSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(CALC_MEMS) 5 262144
	mv mems.txt $(RESULT)/dheap_rand_esparso_$(MAX).262144

	mv medias.txt mems_dheap_rand_esparso_$(MAX).txt
	mv mems_dheap_rand_esparso_$(MAX).txt ./graficos

#sprand_denso
	echo > medias.txt
	$(RAND) 512 32768 251 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(RAND) 512 32768 253 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(RAND) 512 32768 255 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(RAND) 512 32768 257 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(RAND) 512 32768 259 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/dheap_rand_denso_$(MAX).512

	$(RAND) 1024 131072 351 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(RAND) 1024 131072 353 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(RAND) 1024 131072 355 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(RAND) 1024 131072 357 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(RAND) 1024 131072 359 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/dheap_rand_denso_$(MAX).1024

	$(RAND) 2048 524288 451 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(RAND) 2048 524288 453 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(RAND) 2048 524288 455 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(RAND) 2048 524288 457 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(RAND) 2048 524288 459 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 2048 
	mv mems.txt $(RESULT)/dheap_rand_denso_$(MAX).2048

	$(RAND) 4096 2097152 551 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(RAND) 4096 2097152 553 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(RAND) 4096 2097152 555 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(RAND) 4096 2097152 557 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(RAND) 4096 2097152 559 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/dheap_rand_denso_$(MAX).4096

	$(RAND) 8192 8388608 751 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(RAND) 8192 8388608 753 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(RAND) 8192 8388608 755 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(RAND) 8192 8388608 757 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(RAND) 8192 8388608 759 $(RAND_DENSE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/dheap_rand_denso_$(MAX).8192
	mv medias.txt mems_dheap_rand_denso_$(MAX).txt
	mv mems_dheap_rand_denso_$(MAX).txt ./graficos

#spgrid_wide
	echo > medias.txt
	$(GRID) 16 512 281 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 512 283 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 512 285 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 512 287 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 512 289 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/dheap_grid_wide_$(MAX).512

	$(GRID) 16 1024 381 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 1024 383 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 1024 385 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 1024 387 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 1024 389 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/dheap_grid_wide_$(MAX).1024

	$(GRID) 16 2048 481 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 2048 483 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 2048 485 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 2048 487 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 2048 489 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/dheap_grid_wide_$(MAX).2048

	$(GRID) 16 4096 581 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 4096 583 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 4096 585 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 4096 587 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 4096 589 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/dheap_grid_wide_$(MAX).4096

	$(GRID) 16 8192 681 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 8192 683 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 8192 685 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 8192 687 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 8192 689 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/dheap_grid_wide_$(MAX).8192

	$(GRID) 16 16384 781 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 16384 783 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16 16384 785 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(GRID) 16 16384 787 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(GRID) 16 16384 789 $(GRID_SWIDE) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(CALC_MEMS) 5 16384
	mv mems.txt $(RESULT)/dheap_grid_wide_$(MAX).16384
	mv medias.txt mems_dheap_grid_wide_$(MAX).txt
	mv mems_dheap_grid_wide_$(MAX).txt ./graficos
#spgrid_long:
	echo > medias.txt
	$(GRID) 512  16 281 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 512  16 283 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 512  16 285 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 512  16 287 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 512  16 289 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/dheap_grid_long_$(MAX).512

	$(GRID) 1024 16 381 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 1024 16 383 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 1024 16 385 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 1024 16 387 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 1024 16 389 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/dheap_grid_long_$(MAX).1024

	$(GRID) 2048 16 481 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 2048 16 483 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 2048 16 485 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 2048 16 487 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 2048 16 489 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/dheap_grid_long_$(MAX).2048

	$(GRID) 4096 16 581 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 4096 16 583 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 4096 16 585 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 4096 16 587 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 4096 16 589 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/dheap_grid_long_$(MAX).4096

	$(GRID) 8192 16 681 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 8192 16 683 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 8192 16 685 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 8192 16 687 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 8192 16 689 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/dheap_grid_long_$(MAX).8192

	$(GRID) 16384 16 781 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16384 16 783 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16384 16 785 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16384 16 787 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(GRID) 16384 16 789 $(GRID_SLONG) | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 16384
	mv mems.txt $(RESULT)/dheap_grid_long_$(MAX).16384
	mv medias.txt mems_dheap_grid_long_$(MAX).txt
	mv mems_dheap_grid_long_$(MAX).txt ./graficos

NAO_FAZ2:
#spbad_esparso
	echo > medias.txt
	$(BAD) 512 10 -s39011  | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(BAD) 512 10 -s39012 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 512 10 -s39013 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 512 10 -s39014 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 512 10 -s39015 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/dheap_bad_esparso.512

	$(BAD) 1024 10 -s39016 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 1024 10 -s39017 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 1024 10 -s39017 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 1024 10 -s39018 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 1024 10 -s39019 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/dheap_bad_esparso.1024

	$(BAD) 2048 10 -s39020 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 2048 10 -s39021 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 2048 10 -s39022 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 2048 10 -s39023 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 2048 10 -s39024 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/dheap_bad_esparso.2048

	$(BAD) 4096 10 -s39025 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 4096 10 -s39026 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 4096 10 -s39027 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 4096 10 -s39028 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 4096 10 -s39029 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/dheap_bad_esparso.4096

	$(BAD) 8192 10 -s39030 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 8192 10 -s39031 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 8192 10 -s39032 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 8192 10 -s39033 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 8192 10 -s39034 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/dheap_bad_esparso.8192
	mv medias.txt mems_dheap_bad_esparso.txt
	mv mems_dheap_bad_esparso.txt ./graficos

#spbad_denso
	echo > medias.txt
	$(BAD) 512 64 -s39011  | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 512 64 -s39012 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 512 64 -s39013 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 512 64 -s39014 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 512 64 -s39015 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/dheap_bad_denso.512

	$(BAD) 1024 128 -s39016 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 1024 128 -s39017 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 1024 128 -s39017 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 1024 128 -s39018 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 1024 128 -s39019 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/dheap_bad_denso.1024

	$(BAD) 2048 256 -s39020 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 2048 256 -s39021 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 2048 256 -s39022 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 2048 256 -s39023 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 2048 256 -s39024 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/dheap_bad_denso.2048

	$(BAD) 4096 512 -s39025 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 4096 512 -s39026 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 4096 512 -s39027 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 4096 512 -s39028 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(BAD) 4096 512 -s39029 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/dheap_bad_denso.4096

	$(BAD) 8192 1024 -s39030 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(BAD) 8192 1024 -s39031 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(BAD) 8192 1024 -s39032 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(BAD) 8192 1024 -s39033 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(BAD) 8192 1024 -s39034 | $(MEM) $(DHEAP) >> dheap_$(MAX).mem
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/dheap_bad_denso.8192
	mv medias.txt mems_dheap_bad_denso.txt
	mv mems_dheap_bad_denso.txt ./graficos

# TESTA MEMÓRIA USANDO FHEAP
FHEAP: 
#sprand_esparso
	echo > medias.txt
	$(RAND) 8192 16384 561 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 8192 16384 563 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 8192 16384 565 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 8192 16384 567 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 8192 16384 569 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/fheap_rand_esparso_$(MAX).8192

	$(RAND) 16384 32768 661 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 16384 32768 663 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 16384 32768 665 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 16384 32768 667 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 16384 32768 669 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(CALC_MEMS) 5 16384
	mv mems.txt $(RESULT)/fheap_rand_esparso_$(MAX).16384

	$(RAND) 32768 65536 761 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 32768 65536 763 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 32768 65536 765 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 32768 65536 767 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 32768 65536 769 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(CALC_MEMS) 5 32768
	mv mems.txt $(RESULT)/fheap_rand_esparso_$(MAX).32768

	$(RAND) 65536 131072 861 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 65536 131072 863 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 65536 131072 865 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 65536 131072 867 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 65536 131072 869 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(CALC_MEMS) 5 65536
	mv mems.txt $(RESULT)/fheap_rand_esparso_$(MAX).65536

	$(RAND) 131072 262144 961 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 131072 262144 963 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 131072 262144 965 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 131072 262144 967 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(RAND) 131072 262144 969 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(CALC_MEMS) 5 131072
	mv mems.txt $(RESULT)/fheap_rand_esparso_$(MAX).131072

	$(RAND) 262144 524288 361 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 262144 524288 363 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 262144 524288 365 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 262144 524288 367 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(RAND) 262144 524288 369 $(RAND_SPARSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(CALC_MEMS) 5 262144
	mv mems.txt $(RESULT)/fheap_rand_esparso_$(MAX).262144

	mv medias.txt mems_fheap_rand_esparso_$(MAX).txt
	mv mems_fheap_rand_esparso_$(MAX).txt ./graficos

#sprand_denso
	echo > medias.txt
	$(RAND) 512 32768 251 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(RAND) 512 32768 253 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(RAND) 512 32768 255 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(RAND) 512 32768 257 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(RAND) 512 32768 259 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/fheap_rand_denso_$(MAX).512

	$(RAND) 1024 131072 351 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(RAND) 1024 131072 353 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(RAND) 1024 131072 355 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(RAND) 1024 131072 357 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(RAND) 1024 131072 359 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/fheap_rand_denso_$(MAX).1024

	$(RAND) 2048 524288 451 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(RAND) 2048 524288 453 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(RAND) 2048 524288 455 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(RAND) 2048 524288 457 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(RAND) 2048 524288 459 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 2048 
	mv mems.txt $(RESULT)/fheap_rand_denso_$(MAX).2048

	$(RAND) 4096 2097152 551 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(RAND) 4096 2097152 553 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(RAND) 4096 2097152 555 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(RAND) 4096 2097152 557 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(RAND) 4096 2097152 559 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/fheap_rand_denso_$(MAX).4096

	$(RAND) 8192 8388608 751 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(RAND) 8192 8388608 753 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(RAND) 8192 8388608 755 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(RAND) 8192 8388608 757 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(RAND) 8192 8388608 759 $(RAND_DENSE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/fheap_rand_denso_$(MAX).8192
	mv medias.txt mems_fheap_rand_denso_$(MAX).txt
	mv mems_fheap_rand_denso_$(MAX).txt ./graficos

#spgrid_wide
	echo > medias.txt
	$(GRID) 16 512 281 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 512 283 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 512 285 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 512 287 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 512 289 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/fheap_grid_wide_$(MAX).512

	$(GRID) 16 1024 381 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 1024 383 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 1024 385 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 1024 387 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 1024 389 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/fheap_grid_wide_$(MAX).1024

	$(GRID) 16 2048 481 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 2048 483 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 2048 485 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 2048 487 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 2048 489 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/fheap_grid_wide_$(MAX).2048

	$(GRID) 16 4096 581 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 4096 583 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 4096 585 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 4096 587 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 4096 589 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/fheap_grid_wide_$(MAX).4096

	$(GRID) 16 8192 681 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 8192 683 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 8192 685 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 8192 687 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 8192 689 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/fheap_grid_wide_$(MAX).8192

	$(GRID) 16 16384 781 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 16384 783 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16 16384 785 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(GRID) 16 16384 787 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(GRID) 16 16384 789 $(GRID_SWIDE) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(CALC_MEMS) 5 16384
	mv mems.txt $(RESULT)/fheap_grid_wide_$(MAX).16384
	mv medias.txt mems_fheap_grid_wide_$(MAX).txt
	mv mems_fheap_grid_wide_$(MAX).txt ./graficos
#spgrid_long:
	echo > medias.txt
	$(GRID) 512  16 281 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 512  16 283 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 512  16 285 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 512  16 287 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 512  16 289 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/fheap_grid_long_$(MAX).512

	$(GRID) 1024 16 381 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 1024 16 383 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 1024 16 385 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 1024 16 387 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 1024 16 389 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/fheap_grid_long_$(MAX).1024

	$(GRID) 2048 16 481 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 2048 16 483 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 2048 16 485 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 2048 16 487 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 2048 16 489 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/fheap_grid_long_$(MAX).2048

	$(GRID) 4096 16 581 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 4096 16 583 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 4096 16 585 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 4096 16 587 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 4096 16 589 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/fheap_grid_long_$(MAX).4096

	$(GRID) 8192 16 681 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 8192 16 683 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 8192 16 685 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 8192 16 687 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 8192 16 689 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/fheap_grid_long_$(MAX).8192

	$(GRID) 16384 16 781 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16384 16 783 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16384 16 785 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16384 16 787 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(GRID) 16384 16 789 $(GRID_SLONG) | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 16384
	mv mems.txt $(RESULT)/fheap_grid_long_$(MAX).16384
	mv medias.txt mems_fheap_grid_long_$(MAX).txt
	mv mems_fheap_grid_long_$(MAX).txt ./graficos

NAO_FAZ3:
#spbad_esparso
	echo > medias.txt
	$(BAD) 512 10 -s39011  | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(BAD) 512 10 -s39012 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 512 10 -s39013 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 512 10 -s39014 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 512 10 -s39015 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/fheap_bad_esparso.512

	$(BAD) 1024 10 -s39016 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 1024 10 -s39017 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 1024 10 -s39017 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 1024 10 -s39018 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 1024 10 -s39019 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/fheap_bad_esparso.1024

	$(BAD) 2048 10 -s39020 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 2048 10 -s39021 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 2048 10 -s39022 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 2048 10 -s39023 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 2048 10 -s39024 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/fheap_bad_esparso.2048

	$(BAD) 4096 10 -s39025 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 4096 10 -s39026 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 4096 10 -s39027 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 4096 10 -s39028 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 4096 10 -s39029 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/fheap_bad_esparso.4096

	$(BAD) 8192 10 -s39030 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 8192 10 -s39031 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 8192 10 -s39032 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 8192 10 -s39033 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 8192 10 -s39034 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/fheap_bad_esparso.8192
	mv medias.txt mems_fheap_bad_esparso.txt
	mv mems_fheap_bad_esparso.txt ./graficos

#spbad_denso
	echo > medias.txt
	$(BAD) 512 64 -s39011  | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 512 64 -s39012 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 512 64 -s39013 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 512 64 -s39014 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 512 64 -s39015 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/fheap_bad_denso.512

	$(BAD) 1024 128 -s39016 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 1024 128 -s39017 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 1024 128 -s39017 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 1024 128 -s39018 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 1024 128 -s39019 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/fheap_bad_denso.1024

	$(BAD) 2048 256 -s39020 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 2048 256 -s39021 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 2048 256 -s39022 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 2048 256 -s39023 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 2048 256 -s39024 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/fheap_bad_denso.2048

	$(BAD) 4096 512 -s39025 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 4096 512 -s39026 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 4096 512 -s39027 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 4096 512 -s39028 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(BAD) 4096 512 -s39029 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/fheap_bad_denso.4096

	$(BAD) 8192 1024 -s39030 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(BAD) 8192 1024 -s39031 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(BAD) 8192 1024 -s39032 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(BAD) 8192 1024 -s39033 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(BAD) 8192 1024 -s39034 | $(MEM) $(FHEAP) >> fheap_$(MAX).mem
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/fheap_bad_denso.8192
	mv medias.txt mems_fheap_bad_denso.txt
	mv mems_fheap_bad_denso.txt ./graficos

# TESTA MEMÓRIA USANDO BHEAP
BHEAP: 
#sprand_esparso
	echo > medias.txt
	$(RAND) 8192 16384 561 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 8192 16384 563 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 8192 16384 565 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 8192 16384 567 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 8192 16384 569 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/bheap_rand_esparso_$(MAX).8192

	$(RAND) 16384 32768 661 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 16384 32768 663 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 16384 32768 665 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 16384 32768 667 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 16384 32768 669 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(CALC_MEMS) 5 16384
	mv mems.txt $(RESULT)/bheap_rand_esparso_$(MAX).16384

	$(RAND) 32768 65536 761 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 32768 65536 763 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 32768 65536 765 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 32768 65536 767 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 32768 65536 769 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(CALC_MEMS) 5 32768
	mv mems.txt $(RESULT)/bheap_rand_esparso_$(MAX).32768

	$(RAND) 65536 131072 861 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 65536 131072 863 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 65536 131072 865 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 65536 131072 867 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 65536 131072 869 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(CALC_MEMS) 5 65536
	mv mems.txt $(RESULT)/bheap_rand_esparso_$(MAX).65536

	$(RAND) 131072 262144 961 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 131072 262144 963 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 131072 262144 965 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 131072 262144 967 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(RAND) 131072 262144 969 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(CALC_MEMS) 5 131072
	mv mems.txt $(RESULT)/bheap_rand_esparso_$(MAX).131072

	$(RAND) 262144 524288 361 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 262144 524288 363 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 262144 524288 365 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 262144 524288 367 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(RAND) 262144 524288 369 $(RAND_SPARSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(CALC_MEMS) 5 262144
	mv mems.txt $(RESULT)/bheap_rand_esparso_$(MAX).262144

	mv medias.txt mems_bheap_rand_esparso_$(MAX).txt
	mv mems_bheap_rand_esparso_$(MAX).txt ./graficos

#sprand_denso
	echo > medias.txt
	$(RAND) 512 32768 251 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(RAND) 512 32768 253 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(RAND) 512 32768 255 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(RAND) 512 32768 257 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(RAND) 512 32768 259 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/bheap_rand_denso_$(MAX).512

	$(RAND) 1024 131072 351 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(RAND) 1024 131072 353 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(RAND) 1024 131072 355 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(RAND) 1024 131072 357 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(RAND) 1024 131072 359 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/bheap_rand_denso_$(MAX).1024

	$(RAND) 2048 524288 451 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(RAND) 2048 524288 453 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(RAND) 2048 524288 455 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(RAND) 2048 524288 457 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(RAND) 2048 524288 459 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 2048 
	mv mems.txt $(RESULT)/bheap_rand_denso_$(MAX).2048

	$(RAND) 4096 2097152 551 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(RAND) 4096 2097152 553 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(RAND) 4096 2097152 555 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(RAND) 4096 2097152 557 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(RAND) 4096 2097152 559 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/bheap_rand_denso_$(MAX).4096

	$(RAND) 8192 8388608 751 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(RAND) 8192 8388608 753 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(RAND) 8192 8388608 755 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(RAND) 8192 8388608 757 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(RAND) 8192 8388608 759 $(RAND_DENSE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/bheap_rand_denso_$(MAX).8192
	mv medias.txt mems_bheap_rand_denso_$(MAX).txt
	mv mems_bheap_rand_denso_$(MAX).txt ./graficos

#spgrid_wide
	echo > medias.txt
	$(GRID) 16 512 281 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 512 283 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 512 285 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 512 287 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 512 289 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/bheap_grid_wide_$(MAX).512

	$(GRID) 16 1024 381 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 1024 383 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 1024 385 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 1024 387 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 1024 389 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/bheap_grid_wide_$(MAX).1024

	$(GRID) 16 2048 481 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 2048 483 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 2048 485 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 2048 487 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 2048 489 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/bheap_grid_wide_$(MAX).2048

	$(GRID) 16 4096 581 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 4096 583 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 4096 585 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 4096 587 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 4096 589 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/bheap_grid_wide_$(MAX).4096

	$(GRID) 16 8192 681 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 8192 683 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 8192 685 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 8192 687 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 8192 689 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/bheap_grid_wide_$(MAX).8192

	$(GRID) 16 16384 781 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 16384 783 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16 16384 785 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(GRID) 16 16384 787 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(GRID) 16 16384 789 $(GRID_SWIDE) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(CALC_MEMS) 5 16384
	mv mems.txt $(RESULT)/bheap_grid_wide_$(MAX).16384
	mv medias.txt mems_bheap_grid_wide_$(MAX).txt
	mv mems_bheap_grid_wide_$(MAX).txt ./graficos
#spgrid_long:
	echo > medias.txt
	$(GRID) 512  16 281 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 512  16 283 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 512  16 285 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 512  16 287 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 512  16 289 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/bheap_grid_long_$(MAX).512

	$(GRID) 1024 16 381 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 1024 16 383 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 1024 16 385 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 1024 16 387 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 1024 16 389 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/bheap_grid_long_$(MAX).1024

	$(GRID) 2048 16 481 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 2048 16 483 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 2048 16 485 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 2048 16 487 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 2048 16 489 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/bheap_grid_long_$(MAX).2048

	$(GRID) 4096 16 581 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 4096 16 583 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 4096 16 585 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 4096 16 587 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 4096 16 589 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/bheap_grid_long_$(MAX).4096

	$(GRID) 8192 16 681 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 8192 16 683 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 8192 16 685 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 8192 16 687 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 8192 16 689 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/bheap_grid_long_$(MAX).8192

	$(GRID) 16384 16 781 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16384 16 783 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16384 16 785 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16384 16 787 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(GRID) 16384 16 789 $(GRID_SLONG) | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 16384
	mv mems.txt $(RESULT)/bheap_grid_long_$(MAX).16384
	mv medias.txt mems_bheap_grid_long_$(MAX).txt
	mv mems_bheap_grid_long_$(MAX).txt ./graficos

NAO_FAZ4:
#spbad_esparso
	echo > medias.txt
	$(BAD) 512 10 -s39011  | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(BAD) 512 10 -s39012 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 512 10 -s39013 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 512 10 -s39014 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 512 10 -s39015 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/bheap_bad_esparso.512

	$(BAD) 1024 10 -s39016 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 1024 10 -s39017 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 1024 10 -s39017 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 1024 10 -s39018 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 1024 10 -s39019 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/bheap_bad_esparso.1024

	$(BAD) 2048 10 -s39020 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 2048 10 -s39021 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 2048 10 -s39022 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 2048 10 -s39023 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 2048 10 -s39024 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/bheap_bad_esparso.2048

	$(BAD) 4096 10 -s39025 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 4096 10 -s39026 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 4096 10 -s39027 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 4096 10 -s39028 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 4096 10 -s39029 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/bheap_bad_esparso.4096

	$(BAD) 8192 10 -s39030 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 8192 10 -s39031 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 8192 10 -s39032 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 8192 10 -s39033 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 8192 10 -s39034 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/bheap_bad_esparso.8192
	mv medias.txt mems_bheap_bad_esparso.txt
	mv mems_bheap_bad_esparso.txt ./graficos

#spbad_denso
	echo > medias.txt
	$(BAD) 512 64 -s39011  | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 512 64 -s39012 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 512 64 -s39013 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 512 64 -s39014 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 512 64 -s39015 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/bheap_bad_denso.512

	$(BAD) 1024 128 -s39016 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 1024 128 -s39017 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 1024 128 -s39017 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 1024 128 -s39018 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 1024 128 -s39019 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/bheap_bad_denso.1024

	$(BAD) 2048 256 -s39020 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 2048 256 -s39021 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 2048 256 -s39022 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 2048 256 -s39023 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 2048 256 -s39024 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/bheap_bad_denso.2048

	$(BAD) 4096 512 -s39025 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 4096 512 -s39026 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 4096 512 -s39027 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 4096 512 -s39028 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(BAD) 4096 512 -s39029 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/bheap_bad_denso.4096

	$(BAD) 8192 1024 -s39030 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(BAD) 8192 1024 -s39031 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(BAD) 8192 1024 -s39032 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(BAD) 8192 1024 -s39033 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(BAD) 8192 1024 -s39034 | $(MEM) $(BHEAP) >> bheap_$(MAX).mem
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/bheap_bad_denso.8192
	mv medias.txt mems_bheap_bad_denso.txt
	mv mems_bheap_bad_denso.txt ./graficos


# TESTA MEMÓRIA USANDO RHEAP
RHEAP: 
#sprand_esparso
	echo > medias.txt
	$(RAND) 8192 16384 561 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 8192 16384 563 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 8192 16384 565 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 8192 16384 567 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 8192 16384 569 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/rheap_rand_esparso_$(MAX).8192

	$(RAND) 16384 32768 661 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 16384 32768 663 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 16384 32768 665 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 16384 32768 667 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 16384 32768 669 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(CALC_MEMS) 5 16384
	mv mems.txt $(RESULT)/rheap_rand_esparso_$(MAX).16384

	$(RAND) 32768 65536 761 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 32768 65536 763 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 32768 65536 765 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 32768 65536 767 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 32768 65536 769 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(CALC_MEMS) 5 32768
	mv mems.txt $(RESULT)/rheap_rand_esparso_$(MAX).32768

	$(RAND) 65536 131072 861 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 65536 131072 863 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 65536 131072 865 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 65536 131072 867 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 65536 131072 869 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(CALC_MEMS) 5 65536
	mv mems.txt $(RESULT)/rheap_rand_esparso_$(MAX).65536

	$(RAND) 131072 262144 961 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 131072 262144 963 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 131072 262144 965 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 131072 262144 967 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(RAND) 131072 262144 969 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(CALC_MEMS) 5 131072
	mv mems.txt $(RESULT)/rheap_rand_esparso_$(MAX).131072

	$(RAND) 262144 524288 361 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 262144 524288 363 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 262144 524288 365 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 262144 524288 367 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(RAND) 262144 524288 369 $(RAND_SPARSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(CALC_MEMS) 5 262144
	mv mems.txt $(RESULT)/rheap_rand_esparso_$(MAX).262144

	mv medias.txt mems_rheap_rand_esparso_$(MAX).txt
	mv mems_rheap_rand_esparso_$(MAX).txt ./graficos

#sprand_denso
	echo > medias.txt
	$(RAND) 512 32768 251 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(RAND) 512 32768 253 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(RAND) 512 32768 255 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(RAND) 512 32768 257 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(RAND) 512 32768 259 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/rheap_rand_denso_$(MAX).512

	$(RAND) 1024 131072 351 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(RAND) 1024 131072 353 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(RAND) 1024 131072 355 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(RAND) 1024 131072 357 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(RAND) 1024 131072 359 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/rheap_rand_denso_$(MAX).1024

	$(RAND) 2048 524288 451 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(RAND) 2048 524288 453 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(RAND) 2048 524288 455 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(RAND) 2048 524288 457 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(RAND) 2048 524288 459 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 2048 
	mv mems.txt $(RESULT)/rheap_rand_denso_$(MAX).2048

	$(RAND) 4096 2097152 551 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(RAND) 4096 2097152 553 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(RAND) 4096 2097152 555 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(RAND) 4096 2097152 557 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(RAND) 4096 2097152 559 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/rheap_rand_denso_$(MAX).4096

	$(RAND) 8192 8388608 751 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(RAND) 8192 8388608 753 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(RAND) 8192 8388608 755 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(RAND) 8192 8388608 757 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(RAND) 8192 8388608 759 $(RAND_DENSE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/rheap_rand_denso_$(MAX).8192
	mv medias.txt mems_rheap_rand_denso_$(MAX).txt
	mv mems_rheap_rand_denso_$(MAX).txt ./graficos

#spgrid_wide
	echo > medias.txt
	$(GRID) 16 512 281 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 512 283 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 512 285 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 512 287 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 512 289 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/rheap_grid_wide_$(MAX).512

	$(GRID) 16 1024 381 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 1024 383 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 1024 385 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 1024 387 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 1024 389 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/rheap_grid_wide_$(MAX).1024

	$(GRID) 16 2048 481 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 2048 483 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 2048 485 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 2048 487 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 2048 489 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/rheap_grid_wide_$(MAX).2048

	$(GRID) 16 4096 581 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 4096 583 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 4096 585 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 4096 587 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 4096 589 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/rheap_grid_wide_$(MAX).4096

	$(GRID) 16 8192 681 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 8192 683 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 8192 685 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 8192 687 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 8192 689 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/rheap_grid_wide_$(MAX).8192

	$(GRID) 16 16384 781 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 16384 783 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16 16384 785 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(GRID) 16 16384 787 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(GRID) 16 16384 789 $(GRID_SWIDE) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(CALC_MEMS) 5 16384
	mv mems.txt $(RESULT)/rheap_grid_wide_$(MAX).16384
	mv medias.txt mems_rheap_grid_wide_$(MAX).txt
	mv mems_rheap_grid_wide_$(MAX).txt ./graficos
#spgrid_long:
	echo > medias.txt
	$(GRID) 512  16 281 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 512  16 283 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 512  16 285 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 512  16 287 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 512  16 289 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/rheap_grid_long_$(MAX).512

	$(GRID) 1024 16 381 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 1024 16 383 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 1024 16 385 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 1024 16 387 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 1024 16 389 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/rheap_grid_long_$(MAX).1024

	$(GRID) 2048 16 481 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 2048 16 483 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 2048 16 485 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 2048 16 487 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 2048 16 489 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/rheap_grid_long_$(MAX).2048

	$(GRID) 4096 16 581 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 4096 16 583 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 4096 16 585 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 4096 16 587 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 4096 16 589 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/rheap_grid_long_$(MAX).4096

	$(GRID) 8192 16 681 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 8192 16 683 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 8192 16 685 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 8192 16 687 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 8192 16 689 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/rheap_grid_long_$(MAX).8192

	$(GRID) 16384 16 781 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16384 16 783 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16384 16 785 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16384 16 787 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(GRID) 16384 16 789 $(GRID_SLONG) | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 16384
	mv mems.txt $(RESULT)/rheap_grid_long_$(MAX).16384
	mv medias.txt mems_rheap_grid_long_$(MAX).txt
	mv mems_rheap_grid_long_$(MAX).txt ./graficos

NAO_FAZ5:
#spbad_esparso
	echo > medias.txt
	$(BAD) 512 10 -s39011  | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(BAD) 512 10 -s39012 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 512 10 -s39013 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 512 10 -s39014 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 512 10 -s39015 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/rheap_bad_esparso.512

	$(BAD) 1024 10 -s39016 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 1024 10 -s39017 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 1024 10 -s39017 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 1024 10 -s39018 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 1024 10 -s39019 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/rheap_bad_esparso.1024

	$(BAD) 2048 10 -s39020 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 2048 10 -s39021 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 2048 10 -s39022 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 2048 10 -s39023 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 2048 10 -s39024 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/rheap_bad_esparso.2048

	$(BAD) 4096 10 -s39025 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 4096 10 -s39026 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 4096 10 -s39027 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 4096 10 -s39028 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 4096 10 -s39029 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/rheap_bad_esparso.4096

	$(BAD) 8192 10 -s39030 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 8192 10 -s39031 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 8192 10 -s39032 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 8192 10 -s39033 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 8192 10 -s39034 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/rheap_bad_esparso.8192
	mv medias.txt mems_rheap_bad_esparso.txt
	mv mems_rheap_bad_esparso.txt ./graficos

#spbad_denso
	echo > medias.txt
	$(BAD) 512 64 -s39011  | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 512 64 -s39012 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 512 64 -s39013 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 512 64 -s39014 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 512 64 -s39015 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/rheap_bad_denso.512

	$(BAD) 1024 128 -s39016 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 1024 128 -s39017 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 1024 128 -s39017 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 1024 128 -s39018 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 1024 128 -s39019 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/rheap_bad_denso.1024

	$(BAD) 2048 256 -s39020 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 2048 256 -s39021 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 2048 256 -s39022 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 2048 256 -s39023 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 2048 256 -s39024 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/rheap_bad_denso.2048

	$(BAD) 4096 512 -s39025 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 4096 512 -s39026 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 4096 512 -s39027 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 4096 512 -s39028 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(BAD) 4096 512 -s39029 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/rheap_bad_denso.4096

	$(BAD) 8192 1024 -s39030 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(BAD) 8192 1024 -s39031 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(BAD) 8192 1024 -s39032 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(BAD) 8192 1024 -s39033 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(BAD) 8192 1024 -s39034 | $(MEM) $(RHEAP) >> rheap_$(MAX).mem
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/rheap_bad_denso.8192
	mv medias.txt mems_rheap_bad_denso.txt
	mv mems_rheap_bad_denso.txt ./graficos


# TESTA MEMÓRIA USANDO THORUP
THORUP: 
#sprand_esparso
	echo > medias.txt
	$(RAND) 8192 16384 561 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 8192 16384 563 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 8192 16384 565 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 8192 16384 567 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 8192 16384 569 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/thorup_rand_esparso_$(MAX).8192

	$(RAND) 16384 32768 661 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 16384 32768 663 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 16384 32768 665 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 16384 32768 667 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 16384 32768 669 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(CALC_MEMS) 5 16384
	mv mems.txt $(RESULT)/thorup_rand_esparso_$(MAX).16384

	$(RAND) 32768 65536 761 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 32768 65536 763 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 32768 65536 765 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 32768 65536 767 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 32768 65536 769 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(CALC_MEMS) 5 32768
	mv mems.txt $(RESULT)/thorup_rand_esparso_$(MAX).32768

	$(RAND) 65536 131072 861 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 65536 131072 863 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 65536 131072 865 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 65536 131072 867 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 65536 131072 869 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(CALC_MEMS) 5 65536
	mv mems.txt $(RESULT)/thorup_rand_esparso_$(MAX).65536

	$(RAND) 131072 262144 961 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 131072 262144 963 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 131072 262144 965 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 131072 262144 967 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(RAND) 131072 262144 969 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(CALC_MEMS) 5 131072
	mv mems.txt $(RESULT)/thorup_rand_esparso_$(MAX).131072

	$(RAND) 262144 524288 361 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 262144 524288 363 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 262144 524288 365 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 262144 524288 367 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(RAND) 262144 524288 369 $(RAND_SPARSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(CALC_MEMS) 5 262144
	mv mems.txt $(RESULT)/thorup_rand_esparso_$(MAX).262144

	mv medias.txt mems_thorup_rand_esparso_$(MAX).txt
	mv mems_thorup_rand_esparso_$(MAX).txt ./graficos

#sprand_denso
	echo > medias.txt
	$(RAND) 512 32768 251 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(RAND) 512 32768 253 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(RAND) 512 32768 255 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(RAND) 512 32768 257 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(RAND) 512 32768 259 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/thorup_rand_denso_$(MAX).512

	$(RAND) 1024 131072 351 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(RAND) 1024 131072 353 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(RAND) 1024 131072 355 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(RAND) 1024 131072 357 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(RAND) 1024 131072 359 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/thorup_rand_denso_$(MAX).1024

	$(RAND) 2048 524288 451 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(RAND) 2048 524288 453 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(RAND) 2048 524288 455 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(RAND) 2048 524288 457 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(RAND) 2048 524288 459 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 2048 
	mv mems.txt $(RESULT)/thorup_rand_denso_$(MAX).2048

	$(RAND) 4096 2097152 551 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(RAND) 4096 2097152 553 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(RAND) 4096 2097152 555 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(RAND) 4096 2097152 557 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(RAND) 4096 2097152 559 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/thorup_rand_denso_$(MAX).4096

	$(RAND) 8192 8388608 751 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(RAND) 8192 8388608 753 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(RAND) 8192 8388608 755 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(RAND) 8192 8388608 757 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(RAND) 8192 8388608 759 $(RAND_DENSE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/thorup_rand_denso_$(MAX).8192
	mv medias.txt mems_thorup_rand_denso_$(MAX).txt
	mv mems_thorup_rand_denso_$(MAX).txt ./graficos

#spgrid_wide
	echo > medias.txt
	$(GRID) 16 512 281 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 512 283 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 512 285 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 512 287 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 512 289 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/thorup_grid_wide_$(MAX).512

	$(GRID) 16 1024 381 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 1024 383 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 1024 385 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 1024 387 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 1024 389 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/thorup_grid_wide_$(MAX).1024

	$(GRID) 16 2048 481 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 2048 483 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 2048 485 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 2048 487 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 2048 489 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/thorup_grid_wide_$(MAX).2048

	$(GRID) 16 4096 581 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 4096 583 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 4096 585 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 4096 587 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 4096 589 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/thorup_grid_wide_$(MAX).4096

	$(GRID) 16 8192 681 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 8192 683 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 8192 685 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 8192 687 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 8192 689 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/thorup_grid_wide_$(MAX).8192

	$(GRID) 16 16384 781 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 16384 783 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16 16384 785 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(GRID) 16 16384 787 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(GRID) 16 16384 789 $(GRID_SWIDE) | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(CALC_MEMS) 5 16384
	mv mems.txt $(RESULT)/thorup_grid_wide_$(MAX).16384
	mv medias.txt mems_thorup_grid_wide_$(MAX).txt
	mv mems_thorup_grid_wide_$(MAX).txt ./graficos
#spgrid_long:
	echo > medias.txt
	$(GRID) 512  16 281 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 512  16 283 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 512  16 285 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 512  16 287 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 512  16 289 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/thorup_grid_long_$(MAX).512

	$(GRID) 1024 16 381 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 1024 16 383 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 1024 16 385 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 1024 16 387 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 1024 16 389 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/thorup_grid_long_$(MAX).1024

	$(GRID) 2048 16 481 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 2048 16 483 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 2048 16 485 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 2048 16 487 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 2048 16 489 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/thorup_grid_long_$(MAX).2048

	$(GRID) 4096 16 581 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 4096 16 583 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 4096 16 585 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 4096 16 587 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 4096 16 589 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/thorup_grid_long_$(MAX).4096

	$(GRID) 8192 16 681 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 8192 16 683 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 8192 16 685 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 8192 16 687 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 8192 16 689 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/thorup_grid_long_$(MAX).8192

	$(GRID) 16384 16 781 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16384 16 783 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16384 16 785 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16384 16 787 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(GRID) 16384 16 789 $(GRID_SLONG) | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 16384
	mv mems.txt $(RESULT)/thorup_grid_long_$(MAX).16384
	mv medias.txt mems_thorup_grid_long_$(MAX).txt
	mv mems_thorup_grid_long_$(MAX).txt ./graficos

NAO_FAZ6:
#spbad_esparso
	echo > medias.txt
	$(BAD) 512 10 -s39011  | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(BAD) 512 10 -s39012 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 512 10 -s39013 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 512 10 -s39014 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 512 10 -s39015 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/thorup_bad_esparso.512

	$(BAD) 1024 10 -s39016 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 1024 10 -s39017 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 1024 10 -s39017 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 1024 10 -s39018 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 1024 10 -s39019 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/thorup_bad_esparso.1024

	$(BAD) 2048 10 -s39020 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 2048 10 -s39021 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 2048 10 -s39022 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 2048 10 -s39023 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 2048 10 -s39024 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/thorup_bad_esparso.2048

	$(BAD) 4096 10 -s39025 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 4096 10 -s39026 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 4096 10 -s39027 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 4096 10 -s39028 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 4096 10 -s39029 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/thorup_bad_esparso.4096

	$(BAD) 8192 10 -s39030 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 8192 10 -s39031 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 8192 10 -s39032 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 8192 10 -s39033 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 8192 10 -s39034 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/thorup_bad_esparso.8192
	mv medias.txt mems_thorup_bad_esparso.txt
	mv mems_thorup_bad_esparso.txt ./graficos

#spbad_denso
	echo > medias.txt
	$(BAD) 512 64 -s39011  | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 512 64 -s39012 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 512 64 -s39013 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 512 64 -s39014 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 512 64 -s39015 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 512
	mv mems.txt $(RESULT)/thorup_bad_denso.512

	$(BAD) 1024 128 -s39016 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 1024 128 -s39017 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 1024 128 -s39017 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 1024 128 -s39018 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 1024 128 -s39019 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 1024
	mv mems.txt $(RESULT)/thorup_bad_denso.1024

	$(BAD) 2048 256 -s39020 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 2048 256 -s39021 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 2048 256 -s39022 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 2048 256 -s39023 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 2048 256 -s39024 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 2048
	mv mems.txt $(RESULT)/thorup_bad_denso.2048

	$(BAD) 4096 512 -s39025 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 4096 512 -s39026 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 4096 512 -s39027 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 4096 512 -s39028 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(BAD) 4096 512 -s39029 | $(MEM) $(THORUP) >> thorup_$(MAX).mem 
	$(CALC_MEMS) 5 4096
	mv mems.txt $(RESULT)/thorup_bad_denso.4096

	$(BAD) 8192 1024 -s39030 | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(BAD) 8192 1024 -s39031 | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(BAD) 8192 1024 -s39032 | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(BAD) 8192 1024 -s39033 | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(BAD) 8192 1024 -s39034 | $(MEM) $(THORUP) >> thorup_$(MAX).mem
	$(CALC_MEMS) 5 8192
	mv mems.txt $(RESULT)/thorup_bad_denso.8192
	mv medias.txt mems_thorup_bad_denso.txt
	mv mems_thorup_bad_denso.txt ./graficos

####################################################################################
clean_testes:
	rm -f medias.txt tempos.txt potencial.txt mediasfp.txt \
	$(RESULT)/* ./graficos/*.txt mems.txt *.mem \
	heap dheap fheap bheap rheap thorup
clean: 
	$(RM) -f *~ *.o  mestrado.c mestrado.tex programa.c busca.c \
	*.log *.aux *.aux.* *.out *.gb mestrado.ps dimacs/*~ \
	*.bbl *.blg *.brf *.lot *.lof *.dvi mestrado programa \
	*.toc *.idx *ilg *ind *.scn core bib/*~ sty/*~ graficos/*~

####################################################################################
# Compacta todos os arquivos importantes 
####################################################################################
tgz:
	tar -czvf dissertacao_cweb.tgz Makefile *.tex \
 bib/*  sty/* fig/*.eps *.w dimacs/*  geradores/src/* geradores/README* \
	geradores/inputs/* geradores/makefile geradores/doc/* graph/*.eps

all_tgz:
	tar -czvf all_dissertacao_cweb.tgz Makefile *.tex \
 bib/*  sty/* fig/*.eps fig/*.fig *.w dimacs/*  geradores/* graficos/* graph/*











