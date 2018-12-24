set style rect fc lt -1 fs solid 0.15 noborder
set xlabel 'Casos de teste BC'
set ylabel 'Tempo (s)'
plot "bc_pdp_tempo.data" with lines title "Programação Dinamica Primal"
replot "bc_yen_tempo.data" with lines title "Algoritmo de Yen"
replot "bc_hz_tempo.data" with lines title "Handler and Zang"
set terminal pdfcairo
set output "bc_tempo.pdf"
replot
