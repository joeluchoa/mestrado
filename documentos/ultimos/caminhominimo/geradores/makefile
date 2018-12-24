######################################
# makefile for programs and generators
######################################

CCOMP = gcc
CFLAGS = -O3

all: gens

# problem generators
gens: bin/spacyc bin/spgrid bin/sprand bin/spbad

bin/spacyc: src/spacyc.c src/random.c
	$(CCOMP) $(CFLAGS) -o bin/spacyc src/spacyc.c

bin/spgrid: src/spgrid.c src/random.c
	$(CCOMP) $(CFLAGS) -o bin/spgrid src/spgrid.c

bin/sprand: src/sprand.c src/random.c
	$(CCOMP) $(CFLAGS) -o bin/sprand src/sprand.c

bin/spbad: src/spbad.c src/random.c
	$(CCOMP) $(CFLAGS) -o bin/spbad src/spbad.c -lm

clean:
	rm -f *~ bin/* src/*~ input/*~ results/*~ 
