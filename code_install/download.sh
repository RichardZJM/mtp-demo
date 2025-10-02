#!/bin/bash

# This script contains all the git clone commands to download all the data. It does this sequentially so it may take a while. You can, of course, split this into multiple terminals manually.

# ----- MTP LAMMPS with MLIP-3 -----
git clone https://gitlab.com/ashapeev/mlip-3.git
git clone https://gitlab.com/ivannovikov/interface-lammps-mlip-3.git
git clone -b stable https://github.com/lammps/lammps.git mlip-3-lammps


# ----- MTP LAMMPS with New CPU + Kokkos GPU -----
git clone https://github.com/RichardZJM/lammps-mtp-kokkos.git
cp -r mlip-3-lammps new-lammps # Make a copy instead of downloading lammps again.

# ----- MTP Pruning -----
git clone https://github.com/RichardZJM/MTP_basis_optimization.git
git clone https://github.com/RichardZJM/mlip3-extract.git # MLIP-3 fork to extract problem

