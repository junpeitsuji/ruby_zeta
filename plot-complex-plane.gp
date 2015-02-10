set datafile separator ','
set pm3d

set key left top

set zeroaxis
set size square
set xlabel 'real part'
set ylabel 'imaginary part'

set xrange [-40:40]
set yrange [-40:40]
set zrange [0:4]
set view map

set terminal png size 1280,960
set output 'complex-plane.png'
splot 'complex-plane.csv' u 1:2:5 t '' with pm3d
set terminal windows
