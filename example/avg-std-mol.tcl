set outfile [open all-80-mol-avg-std.csv w]
for {set i 2} {$i <= 85} {incr i} {
set filename "z-r$i-mol-vol.csv"
set start_row 1202
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
    puts $outfile "$average, $standard_deviation"

   
} else {
    puts "No matching rows found."
}
} 
exit
