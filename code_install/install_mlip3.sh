#!/bin/bash

# This script contains minimal commands to install mlip-3 with lammps. You may need to modify this sequence for you machine, in which case you should refer to the mlip-3 documentation.

NCORES=1 # You can increase the number of cores to go faster. Just be careful on login nodes.

# Run this code from this directory (the one this script is in)

cd mlip-3
./configure # Default with MPI. You can also build with other compilers and in serial.
make mlp -j $NCORES # Compile mlip-3. 
make libinterface

cd ../interface-lammps-mlip-3
cp ../mlip-3/lib/lib_mlip_interface.a ./

# If you were building this manually, you would now have the option to install other lammps package
# This is done by modifying the preinstall.sh script. 

sh install.sh ../mlip-3-lammps mpi # This runs on 1 core. You can increase that by modifying install.sh
