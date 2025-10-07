#!/bin/bash

set -ueo pipefail

module load Flye/gcc-11.4.1/2.9.6

mkdir -p ./assemblies/assembly_module

flye --nano-hq ./data/SRR33939694.fastq.gz --out-dir ./assemblies/assembly_module --genome-size 0.1m --meta --threads 6 > ./assemblies/assembly_module/module_flye.log 2>&1

mv ./assemblies/assembly_module/assembly.fasta ./assemblies/assembly_module/module_assembly.fasta

rm -r ./assemblies/assembly_module/*-* #get rid of directories

rm ./assemblies/assembly_module/assembly_graph* 

rm ./assemblies/assembly_module/assembly_info*

rm ./assemblies/assembly_module/flye.log

rm ./assemblies/assembly_module/*json

