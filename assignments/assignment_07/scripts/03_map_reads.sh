#!/bin/bash

set -euo pipefail

export PATH=$PATH:/sciclone/home/selozina/programs/bbmap

export PATH=$PATH:/sciclone/home/selozina/programs/samtools-1.22.1

REF="./data/dog_reference/dog_reference_genome.fna"

mkdir -p output

for bee in ./data/clean/*_1_clean.fastq; do ACC=${bee/_1_clean.fastq/}; ACC=${ACC#./data/clean/}; bbmap.sh ref=${REF} in1=${bee} in2=${bee/_1_clean.fastq/_2_clean.fastq} out=./output/${ACC}.sam minid=0.95;done

#get data that matched dog genome 

for sam_view in ./output/*.sam; do ACC=${sam_view#./output/}; ACC=${ACC%.sam}; samtools view -F 4 ${sam_view} > ./output/${ACC}_mapped_to_dog.sam; done
