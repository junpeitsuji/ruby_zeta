set datafile separator ','
#set key left top

set zeroaxis
set size square
set xlabel 'real part'
set ylabel 'imaginary part'

set terminal png enhanced
set output 'critical-line-2.png'
plot 'critical-line.csv' every ::::680 u 3:4 t '| zeta(0.5 + it) |' with line
set terminal windows
