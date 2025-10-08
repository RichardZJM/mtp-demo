#!/bin/bash

# Configuration
MAKE_GPU=false  # true -> copy KOKKOS files and build GPU; false -> CPU-only
NCORES=1    # You can increase the number of cores to go faster. Just be careful on login nodes.
KOKKOS_ARCH="HOPPER90"  # e.g., HOPPER90 for H100, AMPERE80 for A100
package() {
    # Add optional packages here. Examples:
    # make yes-basic
    # make yes-most
    :
}


SRCDIR="new-lammps/src"
cp lammps-mtp-kokkos/LAMMPS/ML-MTP/* "$SRCDIR"/ # Copy source files into src
cd "$SRCDIR"
package
make -j "$NCORES" mpi
cd ../../

if [ "$MAKE_GPU" = true ]; then
    # You may need to load a different version on the cluster. You may need to install it yourself locally.
    if ! module load cuda/12 &>/dev/null; then
        echo "cuda/12 module not available. You may not need to load it (local install) or should attempt a different version. Continuing without it."
    fi
    cp lammps-mtp-kokkos/LAMMPS/KOKKOS/* "$SRCDIR"/ # Copy source files into src
    cd "$SRCDIR"
    make yes-kokkos
    make -j "$NCORES" kokkos_cuda_mpi KOKKOS_ARCH="$KOKKOS_ARCH"
fi
