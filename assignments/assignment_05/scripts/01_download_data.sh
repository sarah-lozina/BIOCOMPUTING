#!/bin/bash
set -ueo pipefail

#set project directory
MAIN_DIR="${HOME}/BIOCOMPUTING/assignments/assignment_05"

cd ${MAIN_DIR}

cd data/raw

wget https://gzahn.github.io/data/fastq_examples.tar

tar -xf fastq_examples.tar

rm fastq_examples.tar
