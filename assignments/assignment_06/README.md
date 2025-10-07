# Assignment 6: Software and Environments 

# Sarah Lozina


# Task 1

bora

cd BIOCOMPUTING/assignments/assignment_06

touch README.md

touch pipeline.sh 

chmod +x pipeline.sh

mkdir scripts 

cd scripts

touch 01_download_data.sh 02_flye_2.9.6_conda_install.sh 02_flye_2.9.6_manual_build.sh 03_run_flye_conda.sh 03_run_flye_local.sh 03_run_flye_module.sh 

chmod +x * 


# Task 2

nano 01_download_data.sh

#!/bin/bash

set -ueo pipefail 

mkdir -p ./data 

cd data

wget https://zenodo.org/records/15730819/files/SRR33939694.fastq.gz #download the raw ONT data 

#check

cd ..

./scripts/01_download_data.sh 

#added fastq file to .gitignore


# Task 3

nano 02_flye_2.9.6_manual_build.sh

#!/bin/bash

set -ueo pipefail 

cd ~

mkdir -p programs 

cd programs

git clone https://github.com/fenderglass/Flye

cd Flye

make

#run the script to install flye locally

cd ..

./scripts/02_flye_2.9.6_manual_build.sh 

#add the location of the executable to my path (bin)

cd ~

cd programs

cd Flye

cd bin #see executable 

pwd #/sciclone/home/selozina/programs/Flye/bin

echo “export PATH=$PATH:/sciclone/home/selozina/programs/Flye/bin” >> ~/.bashrc

exec bash

#check version 

flye -v #2.9.6-b1802


# Task 4

nano 02_flye_2.9.6_conda_install.sh 

#!/bin/bash

set -ueo pipefail

module load miniforge3

source "$(dirname $(dirname $(which conda)))/etc/profile.d/conda.sh"

mamba create -y -n flye-env flye -c bioconda

conda activate flye-env

flye -v

conda env export -n flye-env --no-builds | grep -v "^prefix:" > flye-env.yml

conda deactivate

cd ..

./scripts/02_flye_2.9.6_conda_install.sh 

#flye version is 2.9.6-b1802

cat flye-env.yml #see channels, dependencies 


# Task 5

#learn about flye

flye --help

#required arguments are: type of input read (--nano-hq) and output directory path (--out-dir)

#optional arguments that may be helpful: genome size (--genome-size), threads (—-threads), and (- -meta) to handle the multiple types of phage problem 


# Task 6A: conda run flye

nano 03_run_flye_conda.sh

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


# Task 6B: module run flye

nano 03_run_flye_module.sh

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


# Task 6C: local build run flye 

nano 03_run_flye_local.sh

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


# Task 7

for i in ./assemblies/assembly_*; do echo "${i}/*.log"; tail -n 10 ${i}/*.log; done

#no differences 


# Task 8

#!/bin/bash

set -ueo pipefail

#download the data

./scripts/01_download_data.sh

#local build

./scripts/02_flye_2.9.6_manual_build.sh

#conda build

./scripts/02_flye_2.9.6_conda_install.sh

#run flye with conda

./scripts/03_run_flye_conda.sh

#run flye with module

./scripts/03_run_flye_module.sh

#run flye with local

./scripts/03_run_flye_local.sh

#compare results

for i in ./assemblies/assembly_*; do echo "${i}/*.log"; tail -n 10 ${i}/*.log; done


# Task 9

rm -r assemblies

rm -r data 

rm flye-env.yml

./pipeline.sh #works!!


# Reflection

This pipeline downloads a small data set of sequences from Oxford Nanopore technologies of E. coli phages. Then it gets Flye, a tool that assembles ONT reads into contigs and genomes, using three different environments: conda, local build, and module. The log and fasta files are in the assemblies directory, the data is in the data directory, Flye from the local build is in the programs directory in home, and the scripts are in their own directory. The yml file documents the dependencies and versions of the conda environment and the pipeline script will run all the scripts and generate the appropriate files!

To run this pipeline, simply navigate to the main directory and ./pipeline.sh, which will execute all of the commands in the scripts.

Some challenges I had to overcome were when writing the syntax of the for loop for task 8 and just testing out different logic to make it work! Also, remembering to use relative paths from the assignment 6 directory for removing the excess files in the assembly directories. I had a steep learning curve with this assignment, but now I can confidently say I understand how environments work and how to write and implement a pipeline! I think approaching each task one by one and debugging one at a time instead of running them all only in the pipeline script helped me get a better understanding of the concepts and catch issues early! The method that I think I like the most is module load because it just needs one line of code and can be used immediately. On the next assignment, if the modules are available on the HPC, I will definitely start with module load. 
