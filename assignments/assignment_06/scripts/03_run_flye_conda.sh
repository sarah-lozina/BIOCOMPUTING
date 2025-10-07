#!/bin/bash

set -ueo pipefail

module load miniforge3

source "$(dirname $(dirname $(which conda)))/etc/profile.d/conda.sh"

conda activate flye-env

mkdir -p ./assemblies/assembly_conda

flye --nano-hq ./data/SRR33939694.fastq.gz --out-dir ./assemblies/assembly_conda --genome-size 0.1m --meta --threads 6 > ./assemblies/assembly_conda/conda_flye.log 2>&1

mv ./assemblies/assembly_conda/assembly.fasta ./assemblies/assembly_conda/conda_assembly.fasta

rm -r ./assemblies/assembly_conda/*-* #get rid of directories

rm ./assemblies/assembly_conda/assembly_graph* 

rm ./assemblies/assembly_conda/assembly_info*

rm ./assemblies/assembly_conda/flye.log

rm ./assemblies/assembly_conda/*json

conda deactivate
