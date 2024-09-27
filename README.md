# LocalDielectricMD
Calculating dielectric constant of selected molecules from molecular dynamics (MD) trajectories of heterogeneous systems.

This code is designed to calculate the dielectric constants of specific components within heterogeneous systems using MD trajectories (DCD files) from Nanoscale Molecular Dynamics (NAMD). It can also process trajectories from other packages, such as GROMACS, provided the input files are converted to the required formats.

This repository contains all the necessary scripts to perform dielectric constant calculations for the components of a heterogeneous system. Below is an outline for implementing the code:
An outline for implemementing the code is given below,
<div align="center">
<img width="292" alt="image" src="https://github.com/user-attachments/assets/7d87fb79-8d7e-4299-b9f3-c5e287560271">
</div>

<h2>Fluctuations in dipole moment</h2>
The fluctuations in the dipole moment reflect deviations in the dipole moment over time. 

The se-vs-time.tcl script calculates these fluctuations as a function of time. To run the script, provide the paths to the input structure file (PSF) and the trajectory file (DCD).

Next, define the atom selection in *selText* based on the names in the input PSF file, for example, *"water"*.

`The avg-std-se.tcl` script can then be used to calculate the time-averaged fluctuations over a user-defined time range.

<h2>Volume of selections</h2>

Our code calculates the volume of a selection based on the number of molecules present within the defined selection. The `volume.tcl` script is used to compute the volume, while `avg-std-mol-vol.tcl` calculates the time-averaged volume over a user-defined range.

<h2>Epsilon calculation</h2>

Provide the paths to the CSV file containing the average dipole moment fluctuations and average volumes in the `epsilon.py` script to calculate the dielectric constant.




