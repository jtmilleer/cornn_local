# cornn_local
building cornn_tractography local


# Setup
	git clone https://github.com/jtmilleer/cornn_local.git
	cd cornn_local
	git switch docker_port
	docker build --network=host -t cornn_local .

# Generate Slant
	mkdir -p slant_input slant_output
	cp /path/to/T1.nii slant_input/
	docker pull masidocker/public:deep_brain_seg_v1_1_0_CPU
	docker run -it --rm --network=host \
	  -v $(pwd)/slant_input:/INPUTS/ \
	  -v $(pwd)/slant_output:/OUTPUTS \
	  masidocker/public:deep_brain_seg_v1_1_0_CPU \
	  /extra/run_deep_brain_seg.sh
	  
# Running the docker
	docker run -it --network=host \
	  -v /nas4321:/nas4321 \
	  -v $(pwd):/app \
	  --user <uid>:<gid> \
	  --group-add <nas_group_id> \
	  -e HOME=/app \
	  cornn_local \
	  [/path/to/t1.nii] \
	  [/path/to/output.trk] \
	  [num_threads] \
	  --slant [/path/to/slant_output/FinalResult] \
	  --wml [/path/to/wml_output]


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
