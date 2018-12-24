#/bin/sh
echo "
set term postscript enhanced color 
set grid mxtics ytics xtics mytics
set data style lines
set key left box 
set mytics 2 
set mxtics 2 
set ylabel \"Tempo(ms)\"
set xlabel \"Quantidade de caminhos gerados(k)\"
set datafile separator \";\"
set title \"Comparativo entre os tempos totais e das duas principais subrotinas. (densidade=$1)\"
plot \"d_$1.dat\" using 3:(\$4/\$6) title \"Tempo das arvores Ts e Tt\",\
\"d_$1.dat\" using 3:(\$5/\$6) title \"Tempo da rotina SEP\",\
\"d_$1.dat\" using 3:(\$4/\$6 + \$5/\$6) title \"Soma das duas\"
" | gnuplot > ps/$0_$1.ps
 