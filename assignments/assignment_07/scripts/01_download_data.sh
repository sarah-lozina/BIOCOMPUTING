#!/bin/bash

set -euo pipefail
#to fasterq-dump
export PATH=$PATH:/sciclone/home/selozina/programs/sratoolkit.3.2.1-ubuntu64/bin
#to datasets
export PATH=$PATH:/sciclone/home/selozina/programs

mkdir -p ./data/raw

mkdir -p ./data/dog_reference

#get accession numbers and put into a txt file
cut -d',' -f1 data/SraRunTable_7.csv | tail -n +2 > data/accession.txt

for bee_data in $(cat data/accession.txt); do echo "downloading ${bee_data}"; fasterq-dump ${bee_data} -O data/raw; done

#download the dog data with datasets
datasets download genome taxon "Canis lupus familiaris" --reference --filename ./data/dog_reference/dog.zip; unzip ./data/dog_reference/dog.zip -d ./data/dog_reference

#clean up and rename file 
mv ./data/dog_reference/ncbi_dataset/data/GCF_011100685.1/GCF_011100685.1_UU_Cfam_GSD_1.0_genomic.fna ./data/dog_reference/dog_reference_genome.fna

rm -rf ./data/dog_reference/ncbi_dataset/ ./data/dog_reference/README.md ./data/dog_reference/dog.zip ./data/dog_reference/md5sum.txt
