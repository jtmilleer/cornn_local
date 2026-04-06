ls
./setup.sh
exit
ls /nas4321/Public_Reference_Data/BraTS2020/BraTS2020_TrainingData/MICCAI_BraTS2020_TrainingData/BraTS20_Training*/*t1.nii
./run.sh /nas4321/Public_Reference_Data/BraTS2020/BraTS2020_TrainingData/MICCAI_BraTS2020_TrainingData/BraTS20_Training_001/BraTS20_Training_001_t1.nii
ls
ls /cornn_tractography
cd /cornn_tractography/src
cat generate.sh
cat /cornn_tractography/src/generate.py | head -50
grep -A 3 'add_argument' /cornn_tractography/src/generate.py
clear
cd ..
cd ..
ls
cd ..
ls
cd workspace/
ls
ls /nas4321/Public_Reference_Data/BraTS2020/BraTS2020_TrainingData/MICCAI_BraTS2020_TrainingData/BraTS20_Training_369/
grep -n 'slant\|wml' /cornn_tractography/src/generate.py | head -30
