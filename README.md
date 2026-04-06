# cornn_local
Building cornn_tractography local

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
	git switch docker_port
	docker build --network=host -t cornn_local .

# Generate Slant
SLANT performs whole brain segmentation and must be run on your T1 file first.

	mkdir -p slant_input slant_output
	cp /path/to/T1.nii slant_input/
	docker pull masidocker/public:deep_brain_seg_v1_1_0_CPU
	docker run -it --rm --network=host \
	  -v $(pwd)/slant_input:/INPUTS/ \
	  -v $(pwd)/slant_output:/OUTPUTS \
	  masidocker/public:deep_brain_seg_v1_1_0_CPU \
	  /extra/run_deep_brain_seg.sh

Output will be in `slant_output/FinalResult/`.

# Generate WML output (required before running CoRNN)
WML TractSeg is currently blocked — waiting on source code from MASI Lab to convert to Docker. See TODO.
	  
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

## TODO
- WML TractSeg Docker conversion needed — currently only available as Singularity image

## References
https://github.com/MASILab/cornn_tractography  
https://github.com/MASILab/WM_learning_release  
https://github.com/MASILab/SLANTbrainSeg  
