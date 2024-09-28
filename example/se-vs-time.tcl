#The following script calculates the fluctuations in dipole moment. The default units are (e-Angstrom)^2

# Input:
set psf z.psf
set dcd z-tot-stride.dcd

for {set i 2} {$i <= 84} {incr i} {

#example of spherical selections of varying r in a water box
set selText "water and same residue as (water and (sqrt(x^2+y^2+z^2)<$i))"

#modify if needed
set startFrame 0

# Output files (needed to calculate epsilon):
set outFile z-r$i-values-se-vs-time.csv
set outfile [open z-r$i-se-vs-time.csv w]

puts $outfile "count se"

# Loads the system.
set traj [mol load psf $psf dcd $dcd]
set sel [atomselect $traj $selText]

set nFrames [molinfo $traj get numframes]
puts [format "Reading %i frames." $nFrames]

set out [open $outFile w]

# Starts at "startFrame" and move forward, computing
# the dipole moment at each step.
set sum {0. 0. 0.}
set sumSq 0.
set count 0



for {set f $startFrame} {$f <= $nFrames} {incr f} {
	$sel frame $f
	$sel update

        puts $out "frame $f"
	# Obtain the dipole moment of the selection.
	set p [measure dipole $sel]
	puts $out "P $p"
	set sum [vecadd $sum $p]
	puts $out "sum-dipole $sum"
	set p2 [vecdot $p $p]
	puts $out "P2 $p2"
	set sumSq [expr $sumSq + $p2]
	puts $out "sumSq $sumSq"
	incr count 
	puts $out "count $count"
        
	
	#Gets the length of the net dipole vector of the selection.
        set mulen [veclength $sum]
        puts $out "mulen $mulen"
	
	#Gets the average dipole and dipole^2 of the selection
        set mu [expr $mulen/$count]
        set mu2 [expr $sumSq/$count]
	puts $out "mu $mu"
	puts $out "mu2 $mu2"


	# Computes the mean and standard error.
        set se [expr (($mu2 - $mu*$mu))]
        puts $out "se $se"

	puts $outfile "$f $se"
}
}

close $out

exit








