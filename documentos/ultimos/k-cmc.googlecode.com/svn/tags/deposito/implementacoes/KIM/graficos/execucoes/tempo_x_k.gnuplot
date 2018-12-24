#!/bin/sh
echo "
set term postscript
set grid mxtics ytics xtics mytics
set data style lines
set key left box 
set mytics 2 
set mxtics 2 
set ylabel \"Tempo(ms)\"
set xlabel \"Quantidade de caminhos gerados(k)\"
set title \"Tempo de execucao em funcao do numero de caminhos (densidade=$1)\"
set datafile separator \";\"
plot \"d_$1.dat\" using 3:6 title \"Tempo de execucao\"" | gnuplot > ps/$0_$1.ps 
