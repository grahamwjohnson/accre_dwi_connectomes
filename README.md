# accre_dwi_connectomes
Code to run MRtrix3 with Singularity 3.4 (https://sylabs.io/guides/3.4/user-guide/) containers on Vanderbilt's ACCRE.

This will create the following outputs based on Desikan-Killiany atlas:
SIFT2-weighted connectome 
FA connectome
aparc+aseg registered to DWI
5TT
T1 registered to DWI

The input argument to the singularity 'exec' call in the .slurm file ductates how many times MRTrix's 'tckgen' will be called nad thus how many redundant connectomes will be generated. Multiple connectomes are generated in attamp to cpature stochasticity of probablistic tractography. 

Need to add 'inputs' folder and 'outputs' folder to the project directory (see the .txt files in /code for input and output subdirectory setup)

each input directory must have the following:

t1.nii.gz
dwmri.bval
dwmri.bvec
dwmri.nii.gz
aparc+aseg.mgz (from freesurfer 'recon-all':https://surfer.nmr.mgh.harvard.edu/)
