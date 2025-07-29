#!/bin/bash

#SBATCH --account=<ACCOUNT>
#SBATCH --partition=<PARTITION>
#SBATCH --nodes=1 
#SBATCH --ntasks-per-node=1
#SBATCH --time=03:00:00
#SBATCH --mem=30G 
#SBATCH --gres=gpu:1
####SBATCH --constraint=rhel8
#SBATCH --job-name=pybench_cupy
#SBATCH --output=<PATH_TO_LOGS>/pybench_slurm-%j.out
#SBATCH --error=<PATH_TO_LOGS>/pybench_slurm-%j.err

echo "SLURM Job ID: $SLURM_JOB_ID"
echo "Node List: $SLURM_JOB_NODELIST"
echo "Tasks per node: $SLURM_NTASKS_PER_NODE"

## activate my virtual environment with my python packages
module purge
module load mamba/24.3.0
eval "$('/hpc/software/mamba/24.3.0/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
source "/hpc/software/mamba/24.3.0/etc/profile.d/mamba.sh"
mamba activate <ENV_PREFIX>

## run my script
pytest <PATH_TO_REPO>/pybench/pybench/benchmarks/* --benchmark-json=<PATH_TO_OUTPUT>/benchmark_results.json

