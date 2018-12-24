set style rect fc lt -1 fs solid 0.15 noborder
set xlabel 'Casos de teste Curve'
set ylabel 'Tempo (s)'
plot "curva_pdp_tempo.data" with lines title "Programação Dinamica Primal"
replot "curva_hz_tempo.data" with lines title "Handler and Zang"
set terminal pdfcairo
set output "curva_tempo.pdf"
replot
