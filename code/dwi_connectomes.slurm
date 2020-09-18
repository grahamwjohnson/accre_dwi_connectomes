#!/bin/bash

# NOTE: ntasks and second argument in exec call must match

#SBATCH --account=p_englot_group
#SBATCH --mail-user=graham.w.johnson@vanderbilt.edu
#SBATCH --mail-type=ALL
#SBATCH -J dwi_connectomes
#SBATCH --ntasks=8
#SBATCH --nodes=1
#SBATCH --time=04-12:00:00
#SBATCH --mem=4G
#SBATCH --nice=1000000000
#SBATCH -o /scratch/johnsgw2/projects/dwi_connectomes/code/logs/%A_%a.out
#SBATCH -e /scratch/johnsgw2/projects/dwi_connectomes/code/logs/%A_%a.err
#SBATCH --partition=production
#SBATCH --array=0-236

mapfile -t in_dirs < /scratch/johnsgw2/projects/dwi_connectomes/code/input_dir_list.txt
mapfile -t out_dirs < /scratch/johnsgw2/projects/dwi_connectomes/code/output_dir_list.txt

echo ${in_dirs[$SLURM_ARRAY_TASK_ID]}
echo ${out_dirs[$SLURM_ARRAY_TASK_ID]}

# First input to main.sh is number of tckgen iterations, second is number of threads (0 --> disabled multithreading)
singularity exec -e --contain -B /tmp:/tmp -B ${in_dirs[$SLURM_ARRAY_TASK_ID]}:/INPUTS -B ${out_dirs[$SLURM_ARRAY_TASK_ID]}:/OUTPUTS /scratch/johnsgw2/projects/dwi_connectomes/singularity/dwi_connectomes_v1.2.simg bash /CODE/main.sh 3 0

