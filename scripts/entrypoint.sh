#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Error: Not enough arguments to run."
    echo "Usage: docker run cornn_local [/path/to/.nii/file] [/cornn/out/path] [num_threads]"
    exit 1
fi

NII_PATH=$1
CORNN_OUT=$2
THREADS=${3:-1}

/app/scripts/run.sh "$NII_PATH" "$CORNN_OUT" --num_threads "$THREADS"
