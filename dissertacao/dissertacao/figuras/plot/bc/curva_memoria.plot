set format y "%.0f";
set style rect fc lt -1 fs solid 0.15 noborder
set xlabel 'Casos de teste Curve'
set ylabel 'Memória (KB)'
plot "curva_pdp_memoria.data" with lines title "Programação Dinamica Primal"
replot "curva_hz_memoria.data" with lines title "Handler and Zang"
set terminal pdfcairo
set output "curva_memoria.pdf"
replot
