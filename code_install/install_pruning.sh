#!/bin/bash

# This script contains minimal commands to install the Pruning software.

NCORES=1 # You can increase the number of cores to go faster. Just be careful on login nodes.

# ----- Install MLIP-3 extract -----
# This is an fork needed to extract the matrix problem
cd mlip3-extract
./configure 
make mlp -j $NCORES


# ----- Create Virtual enviroment -----
cd ..
python -m venv VENV
source VENV/bin/activate # Load venv

# ----- Install Python Package -----
# python -m pip install -e MTP_basis_optimization # This is serial only install

# You may need to load mpi4py separately on the clusters. You can try to uncomment the below block
# deactivate # Deactivate
# module load mpi4py/4.0.3
#source VENV/bin/activate # Load venv again

python -m pip install -e MTP_basis_optimization[mpi] # Install with MPI support

#If installing on a cluster using a "salloc" then use the version below to use wheelhouse packages for pip
#python -m pip install -e MTP_basis_optimization[mpi] --no-index 