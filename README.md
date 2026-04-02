# cornn_local
building cornn_tractography local


# Setup
	git clone https://github.com/jtmilleer/cornn_local.git
	cd cornn_local
	git switch docker_port
	docker build --network=host -t cornn_local .
# Running the docker
	docker run -it --network=host \
	  -v /nas4321:/nas4321 \
	  -v $(pwd):/app \
	  --user <your_uid>:<your_gid> \
	  --group-add <nas_group_id> \
	  -e HOME=/app \
	  cornn_local \
	  [/path/to/t1.nii] [/path/to/output.trk] [num_threads]


Note: multithreading may not work?

## TODO
mrconvert build isn't finishing, need to run ./build in /apps/mtrix3 after ./setup.sh (?) Is this only a problem in multithreading?

WML and SLANT steps need still need to happen before cornn actually runs. I haven't had time to set that up yet.
WML is the bigger problem, only runs on singularity.

I have a directory with SLANT files that run locally, but the output is strange. 

fsl installer is complaining that /apps/fsl already exists. Not a big deal as it should be empty when it gets overwritten, but something to look at
## Fixed
cmake multithreading in shell script?
is nibabel being pip installed with setup

tqdm and dipy not pip installed
