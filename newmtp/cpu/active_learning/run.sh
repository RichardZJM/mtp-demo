#!/bin/bash

# Add symlinks to path. Only to ensure executable access for the purposes of this demo.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SYMLINK_DIR="$SCRIPT_DIR/../../../bin"
export PATH="$SYMLINK_DIR:$PATH"


# Run
mpirun -np 4  lmp_newmtp -in in.lmp