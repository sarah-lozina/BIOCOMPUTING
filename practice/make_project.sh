#create directory structure 
Mkdir -p data/clean data/raw output scripts 

#create empty files
touch data/meta.data.csv scripts/01_QC.sh scripts/02_assemble.sh scripts/03_bin.sh scripts/04_refine.sh scripts/05_annotate.sh README.md workflow.sh

#add lines in README.md
nano README.md
