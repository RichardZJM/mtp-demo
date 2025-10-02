#!/bin/bash

# Add symlinks to path. Only to ensure executable access for the purposes of this demo.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SYMLINK_DIR="$SCRIPT_DIR/../../bin"
export PATH="$SYMLINK_DIR:$PATH"

source load_venv 

#python ni20.py # If built for serial

mpirun -np 4 python ni20.py