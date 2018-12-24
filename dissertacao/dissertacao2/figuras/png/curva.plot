set noautoscale
set nolabel
!set noxtics
!set noytics
!set noborder
set nokey
set xrange [0:36]
set yrange [0:26]
set terminal pdf
set pointsize 0.5
set output "curva.pdf"
plot "pontos_curva.txt" with linespoints lt -1 pt 7
set output "curva_aproximada.pdf"
plot "pontos_curva_aproximada.txt" with linespoints lt -1 pt 7
