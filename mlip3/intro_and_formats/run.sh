#!/bin/bash

# Add symlinks to path. Only to ensure executable access for the purposes of this demo.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SYMLINK_DIR="$SCRIPT_DIR/../../bin"
export PATH="$SYMLINK_DIR:$PATH"

# Take a look at the commented configration format, trained potential format, and the untrained potential format. You can use Ctrl+F on "#"s to find all the comments in the files.
# Never modify a trained potential manually!
# These may not be functional due to the inclusion of these comments

# Help commands
mlip3 help
mlip3 list
mlip3 help train