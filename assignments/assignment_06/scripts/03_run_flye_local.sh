#!/bin/bash

set -ueo pipefail

export PATH=${HOME}/programs/Flye/bin:$PATH

mkdir -p ./assemblies/assembly_local

flye --nano-hq ./data/SRR33939694.fastq.gz --out-dir ./assemblies/assembly_local --genome-size 0.1m --meta --threads 6 > ./assemblies/assembly_local/local_flye.log 2>&1

mv ./assemblies/assembly_local/assembly.fasta ./assemblies/assembly_local/local_assembly.fasta

rm -r ./assemblies/assembly_local/*-* #get rid of directories

rm ./assemblies/assembly_local/assembly_graph* 

rm ./assemblies/assembly_local/assembly_info*

rm ./assemblies/assembly_local/flye.log

rm ./assemblies/assembly_local/*json
