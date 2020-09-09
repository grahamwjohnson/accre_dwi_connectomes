# accre_dwi_connectomes
Code to run MRtrix3 with Singularity 3.4 (https://sylabs.io/guides/3.4/user-guide/) containers on Vanderbilt's ACCRE.

This will create the following outputs based on Desikan-Killiany atlas:
SIFT2-weighted connectome 
FA connectome
aparc+aseg registered to DWI
5TT
T1 registered to DWI

The input argument to the singularity 'exec' call in the .slurm file ductates how many times MRTrix's 'tckgen' will be called nad thus how many redundant connectomes will be generated. Multiple connectomes are generated in attamp to cpature stochasticity of probablistic tractography. 

1) Need to add 'inputs' folder and 'outputs' folder to the project directory (see the .txt files in /code for input and output subdirectory setup)

2) Each input directory must have the following:

t1.nii.gz
dwmri.bval
dwmri.bvec
dwmri.nii.gz
aparc+aseg.mgz (from freesurfer 'recon-all':https://surfer.nmr.mgh.harvard.edu/)

3) TO BUILD SINGULARITY:
Example build call (change the directories). This assumes you have the required files/directories in same folder as definition file (e.g. /singularity folder)
# sudo singularity build dwi_connectomes_v1.1.simg dwi_connectomes_def_v1.1.txt

4) RUN SINGULARITY (locally to check if it works, kill it after one iteration)
# singularity exec -e --contain -B /tmp:/tmp -B /home/graham/PROJECTS/dwi_connectomes/inputs/subdir1:/INPUTS -B /home/graham/PROJECTS/dwi_connectomes/outputs/subdir1:/OUTPUTS /home/graham/PROJECTS/dwi_connectomes/singularity/dwi_connectomes_v1.1.simg bash /CODE/main.sh 10

5) Copy to ACCRE
# scp dwi_connectomes user@login.accre.vanderbilt.edu:/scratch/user/projects/

6) Check if it works on ACCRE default gateway
# singularity exec -e --contain -B /tmp:/tmp -B /scratch/user/projects/dwi_connectomes/inputs/subdir1/:/INPUTS -B /scratch/user/projects/dwi_connectomes/outputs/subdir1/:/OUTPUTS /scratch/user/projects/dwi_connectomes/singularity/dwi_connectomes_v1.simg bash /CODE/main.sh 10

7) Submit slurm 
check all absolute paths in dwi_connectomes.slurm and the input_dir_list.txt and output_dir_list.txt are all correct.
check the permissions of all of the paths are 755
# sbatch dwi_connectomes.slurm
