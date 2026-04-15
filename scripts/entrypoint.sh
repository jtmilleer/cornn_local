#!/bin/bash

if [ "$#" -lt 4 ]; then
    echo "Error: Not enough arguments to run."
    echo "Usage: docker run cornn_local [/path/to/.nii/file] [/cornn/out/path] [/slant/out/dir] [/wml/out/dir] [num_threads]"
    exit 1
fi

NII_PATH=$1
CORNN_OUT=$2
SLANT_OUT=$3
WML_OUT=$4
THREADS=${5:-1}

/app/scripts/run.sh "$NII_PATH" "$CORNN_OUT" "--slant $SLANT_OUT" "--wml $WML_OUT" --num_threads "$THREADS"
