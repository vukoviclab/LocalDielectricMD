#The following script calculates dielectric constant (epsilon) using the previously calculated fluctuations in the dipole moment and volume

import pandas as pd
import numpy as np

# Constants (modify the value of temperature if needed)
e_vacuum = 8.85419E-12
kB = 1.38065E-23
T = 310

# Reads the input file containing volumes
df1 = pd.read_csv('all-mol-vol-avg-std.csv')
df1.columns = df1.columns.str.strip()  # Removes spaces
volume_water_m3 = df1['avg volume']

# Read the input file for containing dipole moment
df3 = pd.read_csv('z-se-vs-time.csv')
df3.columns = df3.columns.str.strip()  # Removes spaces
avg_se = df3['avg fluctuations']
std_dev_se = df3['std dev fluctuations']

# Calculation of epsilon (dielectric constant)
avg_epsilon = 1 + (avg_se / (3 * e_vacuum * kB * T * volume_water_m3))
std_dev_epsilon = 1 + (std_dev_se / (3 * e_vacuum * kB * T * volume_water_m3))

# Puts avg molecules, avg epislon and std dev of epsilon in the output
results_df = pd.DataFrame({
    'avg molecules': df1['avg molecules'],
    'avg epsilon': avg_epsilon,
    'std dev epsilon': std_dev_epsilon
})

# Saves the output in a CSV file
results_df.to_csv('/content/epsilon_results.csv', index=False)

