# cornn_local
Building cornn_tractography locally

## Prerequisites
- Docker installed
- NVIDIA GPU (recommended)
- Access to the johnsonhj_research NAS group

## Getting your user IDs (needed for NAS access)
Run these on the host machine:

	id
	getent group johnsonhj_research
	


# Setup
	git clone https://github.com/jtmilleer/cornn_local.git
	cd cornn_local
	docker build --network=host -t cornn_local --build-arg THREADS=num_threds_for_build .
Note: THREADS defaults to 1 if not passed in

# Generate Slant
SLANT performs whole brain segmentation and must be run on your T1 file first.

	mkdir -p slant_input slant_output slant_home
	touch slant_home/.bashrc
	cp /path/to/T1.nii.gz slant_input/
	docker pull masidocker/public:deep_brain_seg_v1_1_0_CPU
	docker run -it --rm --network=host \
  		--user $(id -u):$(id -g) \
  		-e HOME=/homedir \
  		-v $HOME/slant_home:/homedir \
  		-v $HOME/slant_input:/INPUTS/ \
  		-v $HOME/slant_output:/OUTPUTS \
  		masidocker/public:deep_brain_seg_v1_1_0_CPU \
  		/extra/run_deep_brain_seg.sh



Output will be in `slant_output/FinalResult/`.

# Generate WML output (required before running CoRNN)
WML TractSeg is currently blocked — waiting on source code from MASI Lab to convert to Docker. See TODO.
	  
# Running the docker
	docker run -it --network=host \
	  -v /nas4321:/nas4321 \
	  -v $(pwd):/app \
	  --user $(id -u):$(id -g) \
	  --group-add <nas_group_id> \
	  -e HOME=/app \
	  cornn_local \
	  [/path/to/t1.nii] \
	  [/path/to/output.trk] \
	  [num_threads] \
	  --slant [/path/to/slant_output/FinalResult] \
	  --wml [/path/to/wml_output]

## TODO
- WML TractSeg Docker conversion needed — currently only available as Singularity image
- git repo is ~100MB, pretty sure it's due to .cache and .local folders still being tracked, even though they're not in present version. Can this be reduced?

## References
https://github.com/MASILab/cornn_tractography  
https://github.com/MASILab/WM_learning_release  
https://github.com/MASILab/SLANTbrainSeg  

## WML without singularity
https://github.com/jtmilleer/WML_local/tree/main 

Now that singulary is on dendrite, I was able to run `singularity inspect --deffile tractSeg.simg` to see the build file. 

With a series of `singularity exec tractSeg.simg cp -r /path/to/wanted/directory /path/to/destination` commands, I was able to extract file from it. They can be seen as `_extracted` directores in the repo.

The readme in the repo talks about a few issues i've been running into. I don't have time to fix them at the moment, it's an ongoing process. Henry, if you would like to work on it, you are welcome to. You should be able to push to it. 


