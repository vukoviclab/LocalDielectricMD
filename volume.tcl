# Input:
set psf /path-to-PSF-file/file.psf
set dcd /path-to-DCD-file/file.dcd

for {set i 2} {$i <= 3} {incr i} {

#example of spherical selections of varying r in a water box
set selText "water and same residue as (water and (sqrt(x^2+y^2+z^2)<$i))"

#modify if needed (should be same as that chosen for se-vs-time.tcl to be consistent)
set startFrame 0

# Output:
set outfile1 [open z-r$i-mol-vol.csv w]

puts $outfile1 "frame mol vol"

# Get the time change between frames in femtoseconds.

# Load the system.
set traj [mol load psf $psf dcd $dcd]
set sel [atomselect $traj $selText]

# Choose nFrames to be the smaller of the two.
set nFrames [molinfo $traj get numframes]
puts [format "Reading %i frames." $nFrames]

# Start at "startFrame" and move forward, computing
# the dipole moment at each step.

for {set f $startFrame} {$f <= $nFrames} {incr f} {
	$sel frame $f
	$sel update


set numMolecules [$sel num]
    if {$numMolecules == 0} {
        # No molecules in the selection, skip this frame.
        continue
    }

     # Obtain the molecules and volume of the selection.
        set imol [expr [ $sel num]/3 ]
        set vol [expr ($imol*18.01528)/((6.022*10**23)*0.98)]
        set ivolM3 [expr $vol/10**6]
       puts $outfile1 "$f $imol $ivolM3"
    
}
}

close $out

exit








