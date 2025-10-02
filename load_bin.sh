#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Default install locations
CODE_INSTALL_DIR=$( cd -- "$SCRIPT_DIR/code_install" &> /dev/null && pwd ) # !!!!! Change this location if needed !!!!!
SYMLINK_DIR="$SCRIPT_DIR/bin"  # Child directory to hold symlinks

echo "Code install directory: $CODE_INSTALL_DIR"
echo "Symlink directory: $SYMLINK_DIR"

# Create symlink folder if it doesn't exist
mkdir -p "$SYMLINK_DIR"

# Helper function to create symlinks
create_symlink() {
    local target="$1"
    local link_name="$2"
    if [ -f "$target" ]; then
        ln -sf "$target" "$SYMLINK_DIR/$link_name"
        echo "Linked $link_name -> $target"
    else
        echo "Warning: $target not found, skipping $link_name"
    fi
}

# Symlinks for main executables
create_symlink "$CODE_INSTALL_DIR/mlip-3/bin/mlp" "mlip3"
create_symlink "$CODE_INSTALL_DIR/mlip3-extract/bin/mlp" "mlip3_extract"
create_symlink "$CODE_INSTALL_DIR/interface-lammps-mlip-3/lmp_mpi" "lmp_mlip3"
create_symlink "$CODE_INSTALL_DIR/VENV/bin/activate" "load_venv"


# !!!!!! Uncomment based on compilation type !!!!!!
# CPU
create_symlink "$CODE_INSTALL_DIR/new-lammps/src/lmp_mpi" "lmp_newmtp"
# GPU
# create_symlink "$CODE_INSTALL_DIR/new-lammps/src/lmp_kokkos_cuda_mpi" "lmp_newmtp"

