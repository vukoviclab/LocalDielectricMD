#The following script calculates the average fluctuations in the dipole  moment over time and converts the values to Coulomb-meter square, (C-m)^2

#define the name for the output file
set outfile1 [open z-se-vs-time.csv w]

puts $outfile1 "avg fluctuations, std dev fluctuations"

for {set i 2} {$i <= 84} {incr i} {
set filename "z-r$i-se-vs-time.csv"
#define here the starting frame (row) for average 
set start_row 1202
#define here the end frame (row) for average
set end_row 1502

set sum 0
set count 0
set squared_diff_sum 0

set file [open $filename r]
while {[gets $file line] != -1} {
    set columns [split $line]
    set col1 [lindex $columns 0]
    set col2 [lindex $columns 1]

    if {$col1 >= $start_row && $col1 <= $end_row} {
        set sum [expr {$sum + $col2}]
        set squared_diff_sum [expr {$squared_diff_sum + ($col2 * $col2)}]
        incr count
    }
}
close $file

if {$count > 0} {
    set average [expr {$sum / $count}]
    set variance [expr {($squared_diff_sum / $count) - ($average * $average)}]
    set standard_deviation [expr {sqrt($variance)}]
#    puts $outfile "Average: $average"
#    puts $outfile "Standard Deviation: $standard_deviation"

    #convert to C-m
   set seC [expr $average*1.6*1.6*pow(10, -58)]
   set stdC [expr $standard_deviation*1.6*1.6*pow(10, -58)]
   puts "avg fluctuation $seC (C-m)^2"
   puts "std fluctuation $stdC (C-m)^2"
   puts $outfile1 "$seC, $stdC"
   
} else {
    puts "No matching rows found."
}
} 
exit
