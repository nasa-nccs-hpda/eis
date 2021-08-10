#!/bin/bash
#SBATCH --job-name eis_zarr_conversion 
#SBATCH -o zarr.out
#SBATCH -e zarr.err
#SBATCH --time=12:00:00 
#SBATCH --ntasks-per-node=1
#SBATCH --constraint="sky|hasw"

module load singularity/3.7.0
export SINGULARITY_CACHEDIR="$NOBACKUP/containers/.singularity"
export SINGULARITY_TMPDIR="$NOBACKUP/containers/.singularity"

#Change the directory paths to your local path accordingly
singularity exec -B /discover/nobackup/bmcandr1:/discover/nobackup/bmcandr1,/discover/nobackup/projects/eis_freshwater/lahmers:/discover/nobackup/projects/eis_freshwater/lahmers /discover/nobackup/bmcandr1/containers/eis_zarr.sif python /usr/local/eis_smce/workflows/zarr_conversion.py /discover/nobackup/bmcandr1/containers/zc.cfg
