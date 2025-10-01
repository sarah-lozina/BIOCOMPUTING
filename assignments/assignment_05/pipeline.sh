#!/bin/bash
set -ueo pipefail

MAIN_DIR="${HOME}/BIOCOMPUTING/assignments/assignment_05"

cd ${MAIN_DIR}

echo "download the data"

./scripts/01_download_data.sh

echo "use fastp.sh"

for i in ./data/raw/*_R1_*; do ./scripts/02_run_fastp.sh $i; done
