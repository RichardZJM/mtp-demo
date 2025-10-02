#!/bin/bash

# This script contains minimal commands to install the new lammps build with GPU support on Cuda. You may need to modify this sequence for your machine or for AMD.
# Building with GPU can be very finicky. Most, of the time it is an issue with Kokkos installation, not with the new code. If you have issues read the docs and ask AI.

# !!!!! If you are on the cluster and building for GPU, you need to module load Cuda or the AMD equivalent !!!!!
MODE="cpu" #  "cpu" or "gpu": CPU only install or GPU with Kokkos
NCORES=1 # You can increase the number of cores to go faster. Just be careful on login nodes.


# Run this code from this directory (the one this script is in)
# ----- Copy src files into lammps -----
cp lammps-mtp-kokkos/LAMMPS/ML-MTP/* new-lammps/src
if [ "$MODE" = "gpu" ]; then
    cp lammps-mtp-kokkos/LAMMPS/KOKKOS/*  new-lammps/src
fi

cd new-lammps/src
# It is at this point that you can install other packages. For example:
# make yes-basic
# make yes-most

# ----- Compile -----
if [ "$MODE" = "gpu" ]; then
    make yes-kokkos
    # Change the KOKKOS_ARCH based on the GPU you compile for. 
    make -j $NCORES kokkos_cuda_mpi KOKKOS_ARCH=HOPPER90 # HOPPER90 for H100, AMPERE80 for A100
else
    make -j $NCORES mpi
fi
