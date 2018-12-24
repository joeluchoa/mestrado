set style rect fc lt -1 fs solid 0.15 noborder
set ylabel 'Consumo de recursos (r)'
set xlabel 'Custo (c)'
set style fill transparent pattern 5
set label " (1, 8)" at 1,8
set label " (3, 6)" at 3,6
set label " (4, 5)" at 4,5
set label " (8, 2)" at 8,2
set object 1 rect from 1, 8 to 10, 10 fc ls -1 fs noborder
set object 2 rect from 3, 6 to 10, 10 fc ls -1 fs noborder
set object 3 rect from 4, 5 to 10, 10 fc ls -1 fs  noborder
set object 4 rect from 8, 2 to 10, 10 fc ls -1 fs noborder
plot [0:10][0:10] "steps.dat" notitle with points
set terminal pdfcairo
set output "step-function.pdf"
replot
set term epslatex
set output "step-function.eps"
replot
