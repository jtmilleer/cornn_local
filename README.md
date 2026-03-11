# cornn_local
building cornn_tractography local

# Setup
    git clone https://github.com/jtmilleer/cornn_local.git`
    cd cornn_local 
    ./setup.sh 
    ./run.sh /path/to/.nii.gz /path/to/out/.trk --slant /path/to/slant_output --wml /path/to0/wml_output

./setup.sh can be ran with multithreading, use
`./setup.sh num_threads` to run with `num_threads`
or 
`./setup.sh $(nproc)` to use all threads

Note: multithreading does not actually work at the moment

## TODO
mrconvert build isn't finishing, need to run ./build in /apps/mtrix3 after ./setup.sh (?)

fsl installer is complaining that /apps/fsl already exists. Not a big deal as it should be empty when it gets overwritten, but something to look at
## Fixed
cmake multithreading in shell script?
is nibabel being pip installed with setup

tqdm and dipy not pip installed
