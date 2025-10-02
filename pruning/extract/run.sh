#!/bin/bash

# Add symlinks to path. Only to ensure executable access for the purposes of this demo.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SYMLINK_DIR="$SCRIPT_DIR/../../bin"
export PATH="$SYMLINK_DIR:$PATH"

OUT_DIR=./out
mkdir -p "$OUT_DIR"

# Extract the problem. Needs a trained potential and the training set. Writes xtwx and xtwy. Prints yty and average neighbour count.
mpirun -np 4 mlip3_extract extract_problem ni20.almtp train.cfg $OUT_DIR/xtwx.bin $OUT_DIR/xtwy.bin 

# Evaluate the base loss
mpirun -np 4 mlip3_extract calculate_loss ni20.almtp train.cfg


# Note that this example uses subset of the training set to reduce the demo footprint and runtime for a demo
# The sample output is the results from the full training set