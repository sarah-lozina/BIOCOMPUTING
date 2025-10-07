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

