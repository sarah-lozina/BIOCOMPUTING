## Assignment 5: Write Once, Run on Everything - Bash Pipelines

# Sarah Lozina


# Task 1: Setup assignment_5 directory

bora

cd BIOCOMPUTING/assignments/assignment_05 

mkdir data log scripts #make directories 

cd data 

mkdir raw trimmed

#make files

cd ..

touch pipeline.sh README.md 

chmod +x pipeline.sh

cd scripts

touch 01_download_data.sh 02_run_fastp.sh

chmod +x 01_download_data.sh 02_run_fastp.sh 


# Task 2: Script to download and prepare fastq data

nano 01_download_data.sh

#!/bin/bash
set -ueo pipefail

#set project directory
MAIN_DIR="${HOME}/BIOCOMPUTING/assignments/assignment_05"

cd ${MAIN_DIR}

cd data/raw

wget https://gzahn.github.io/data/fastq_examples.tar

tar -xf fastq_examples.tar

rm fastq_examples.tar


# Task 3: Install and explore the fastp tool 

cd ~/programs

#download the latest build

wget http://opengene.org/fastp/fastp

chmod a+x ./fastp

#I already had the path to programs in my .bashrc and when I type fastp I get the help menu whether I call it from programs or BIOCOMPUTING.


# Task 4: Script to run fastp

nano 02_run_fastp.sh

#!/bin/bash

set -ueo pipefail

#set project directory
 
#MAIN_DIR="${HOME}/BIOCOMPUTING/assignments/assignment_05"

#cd ${MAIN_DIR}

FWD_IN=${1}

REV_IN=${FWD_IN/_R1_/_R2_}

FWD_OUT=${FWD_IN/.fastq.gz/.trimmed.fastq.gz}

REV_OUT=${REV_IN/.fastq.gz/.trimmed.fastq.gz}

fastp --in1 $FWD_IN --in2 $REV_IN --out1 ${FWD_OUT/raw/trimmed} --out2 ${REV_OUT/raw/trimmed} --json /dev/null --html /dev/null --trim_front1 8 --trim_front2 8 --trim_tail1 20 --trim_tail2 20 --n_base_limit 0 --length_required 100 --average_qual 20

cd ..

./scripts/02_run_fastp.sh ./data/raw/6083_001_S1_R1_001.subset.fastq.gz

cd data/trimmed #see two files!


# Task 5: ‘pipeline.sh’ script

nano pipeline.sh

#!/bin/bash

set -ueo pipefail

MAIN_DIR="${HOME}/BIOCOMPUTING/assignments/assignment_05"

cd ${MAIN_DIR}

echo "download the data"

./scripts/01_download_data.sh

echo "use fastp.sh"

for i in ./data/raw/*_R1_*; do ./scripts/02_run_fastp.sh $i; done

./pipeline.sh


# Task 6: Delete all the data files and start over 

rm -rf ./data/raw/* ./data/trimmed/*

./pipeline.sh


## How to use the pipeline

Before beginning it is recommended that you have a file structure set up that has a data directory (with two subdirectories: raw and trimmed), a scripts directory (where put scripts 01_download_data.sh and 02_run_fastp.sh).

Running pipeline.sh (./pipeline.sh) (after making it executable chmod +x) will dowload and extract FASTQ data, putting the raw data in a directory inside of the data directory via the 01_download_data.sh script and the processes a single sample’s paired reads via 02_run_fastp.sh. Using this pipeline you can process multiple samples more efficiently than one at a time!


# Reflection 

This assignment went relatively smoothly! There were a few times when I forgot a “ or used a . instead of a _ when writing the scripts because of rushing. So in the future I will try to think through and check every line as I go to limit those small errors! We split this into two scripts and a final pipeline script because modular coding is best practice for debugging and pinpointing errors! The cons of this approach is that it takes a bit longer to put together and requires access to all of those scripts and moving directories. I gained a better understanding of for loops in bash and utilizing parameter expansion. These are both things I want to continue practicing! I also learned how to implement a pipeline and find it helpful to think of it as calling different functions in Python.
