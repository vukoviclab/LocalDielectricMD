#The following script calculates the average for the number of molecules and volumes over the defined time of trajectory

# Open a single output file
set outfile [open all-80-mol-vol-avg-std.csv w]

puts $outfile "avg molecules, std dev molecules, avg volume, std dev volume"

# Loop over files defined to be used for calculating the average 
for {set i 2} {$i <= 84} {incr i} {
    set filename "z-r$i-mol-vol.csv"
    set start_row 1202
    set end_row 1502

    set sum_mol 0
    set count_mol 0
    set squared_diff_sum_mol 0

    set sum_vol 0
    set count_vol 0
    set squared_diff_sum_vol 0

    set file [open $filename r]
    while {[gets $file line] != -1} {
        set columns [split $line]
        set col1 [lindex $columns 0]
        set col2 [lindex $columns 1]
        set col3 [lindex $columns 2]

        # Processes the rows within the specified range
        if {$col1 >= $start_row && $col1 <= $end_row} {
            # Column 2 (mol)
            set sum_mol [expr {$sum_mol + $col2}]
            set squared_diff_sum_mol [expr {$squared_diff_sum_mol + ($col2 * $col2)}]
            incr count_mol

            set sum_vol [expr {$sum_vol + $col3}]
            set squared_diff_sum_vol [expr {$squared_diff_sum_vol + ($col3 * $col3)}]
            incr count_vol
        }
    }
    close $file

    # Calculates the average and standard deviations for column 2 (mol)
    if {$count_mol > 0} {
        set average_mol [expr {$sum_mol / $count_mol}]
        set variance_mol [expr {($squared_diff_sum_mol / $count_mol) - ($average_mol * $average_mol)}]
        set stddev_mol [expr {sqrt($variance_mol)}]
    } else {
        puts "No matching rows found for mol."
        set average_mol "N/A"
        set stddev_mol "N/A"
    }

    # Calculates the average and standard deviations for column 3 (vol)
    if {$count_vol > 0} {
        set average_vol [expr {$sum_vol / $count_vol}]
        set variance_vol [expr {($squared_diff_sum_vol / $count_vol) - ($average_vol * $average_vol)}]
        set stddev_vol [expr {sqrt($variance_vol)}]
    } else {
        puts "No matching rows found for vol."
        set average_vol "N/A"
        set stddev_vol "N/A"
    }

    puts $outfile "$average_mol, $stddev_mol, $average_vol, $stddev_vol"
}

close $outfile
exit

