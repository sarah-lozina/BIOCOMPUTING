#!/bin/bash
#SBATCH --job-name=assignment_07
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=1-00:00:00
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --mail-user=selozina@wm.edu
#SBATCH -o /sciclone/home/selozina/BIOCOMPUTING/assignments/assignment_07/output/assignment_07.out
#SBATCH -e /sciclone/home/selozina/BIOCOMPUTING/assignments/assignment_07/output/assignment_07.err

set -euo pipefail

mkdir -p output

./scripts/01_download_data.sh

./scripts/02_clean_reads.sh

./scripts/03_map_reads.sh

