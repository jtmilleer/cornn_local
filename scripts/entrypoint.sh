#!/bin/bash

if [ "$#" -lt 3 ]; then
    echo "Error: Not enough arguments to run."
    echo "Usage: docker run cornn_scripts [num_threads_for_build] [/path/to/.nii/file] [/cornn/out/path]"
    exit 1  
fi



THREADS=$1
NII_PATH=$2
CORNN_OUT=$3



/app/scripts/setup.sh "$THREADS"

/app/scripts/run.sh "$@"
