# cornn_local
building cornn_tractography local


# Setup
	git clone https://github.com/jtmilleer/cornn_local.git
	git switch docker_port
	docker build -t cornn_scripts .
# Running the docker
	docker run --rm \
	   -v /tmp:tmp \
	   cornn_scrips [num_threads_for_build] [/path/to/.nii/] [/path/to/cornn/out] 


Note: multithreading may not work?

## TODO
mrconvert build isn't finishing, need to run ./build in /apps/mtrix3 after ./setup.sh (?) Is this only a problem in multithreading?
WML and SLANT steps need still need to happen before cornn actually runs. I haven't had time to set that up yet.
WML is the bigger problem, only runs on singularity.

fsl installer is complaining that /apps/fsl already exists. Not a big deal as it should be empty when it gets overwritten, but something to look at
## Fixed
cmake multithreading in shell script?
is nibabel being pip installed with setup

tqdm and dipy not pip installed
