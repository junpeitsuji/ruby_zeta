set datafile separator ','

set xrange [0:100]

set size 1.0,0.6
set xlabel 't'
set ylabel '| zeta(0.5 + it) |'
set view map

set terminal png enhanced
set output 'critical-line-1.png'
plot 'critical-line.csv' u 2:5 t '' with line
set terminal windows
