#!/bin/bash

# --- 1. Load the Environment Variables ---
# These replicate the %environment section of your Singularity file
export PATH="/apps/mrtrix3/bin:$PATH"

export FSLDIR=/apps/fsl
[ -f ${FSLDIR}/etc/fslconf/fsl.sh ] && . ${FSLDIR}/etc/fslconf/fsl.sh
export PATH=${FSLDIR}/bin:${PATH}

export ANTSPATH=/apps/ants/bin/
export PATH=${ANTSPATH}:$PATH

# CUDA (Ensure these paths match your actual CUDA installation)
export CUDA_HOME="/usr/local/cuda"
export PATH="${CUDA_HOME}/bin:$PATH"
export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:$LD_LIBRARY_PATH"

# --- 2. Activate the Virtual Environment ---
# Since you installed cornn_tractography into a venv, you must activate it
source /cornn_tractography/venv/bin/activate

# --- 3. The Runscript Logic ---
# This replicates the %runscript section exactly
# $@ passes all arguments from this script to generate.sh
xvfb-run -a \
    --server-num=$((65536+$$)) \
    --server-args="-screen 0 1600x1280x24 -ac" \
    bash /cornn_tractography/src/generate.sh "$@"

# Optional: deactivate when done
deactivate
