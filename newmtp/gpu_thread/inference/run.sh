#!/bin/bash

# Add symlinks to path. Only to ensure executable access for the purposes of this demo.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SYMLINK_DIR="$SCRIPT_DIR/../../../bin"
export PATH="$SYMLINK_DIR:$PATH"


# Run
mpirun -np 1 lmp_newmtp -in in.lmp -k on g 1 -sf kk -pk kokkos newton on neigh half