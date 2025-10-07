#!/bin/bash

set -ueo pipefail

module load miniforge3

source "$(dirname $(dirname $(which conda)))/etc/profile.d/conda.sh"

mamba create -y -n flye-env flye -c bioconda

conda activate flye-env

flye -v

conda env export -n flye-env --no-builds | grep -v "^prefix:" > flye-env.yml

conda deactivate
