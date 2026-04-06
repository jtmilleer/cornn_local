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

## References
https://github.com/MASILab/WM_learning_release
https://github.com/MASILab/cornn_tractography
