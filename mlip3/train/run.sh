#!/bin/bash

# Add symlinks to path. Only to ensure executable access for the purposes of this demo.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SYMLINK_DIR="$SCRIPT_DIR/../../bin"
export PATH="$SYMLINK_DIR:$PATH"

# Possible MTP levels
#6.almtp  10.almtp  14.almtp  18.almtp  22.almtp  26.almtp  depreciated-02.almtp  08.almtp  12.almtp  16.almtp  20.almtp  24.almtp  28.almtp  depreciated-04.almtp

# Print training options
mlip3 help train

# Train a potential
mpirun -np 4 mlip3 train 10.almtp train.cfg --iteration_limit=100 --save_to=done.almtp

# See how well we did. Train already prints this by default, so it's not needed here.
mpirun -np 4 mlip3 check_errors 10.almtp train.cfg