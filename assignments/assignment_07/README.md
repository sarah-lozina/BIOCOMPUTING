## Sarah Lozina 

## Assignment 7: SLURM Job Submission & Public Data


# Task 1

cd BIOCOMPUTING/assignments/assignment_07

touch README.md

mkdir output

mkdir scripts

cd scripts 

touch 01_download_data.sh 02_clean_reads.sh 03_map_reads.sh

chmod +x *

cd ..

touch assignment_07_pipeline.slurm

mkdir data 

#I will make the rest of the directories as I write the other scripts 


# Task 2

#chose bee: Apis mellifera

#searched: bee shotgun, metagenome, illumina

#((“Apis mellifera"[Organism] OR bee[All Fields]) AND shotgun[All Fields] AND ("metagenome"[Organism] OR metagenome[All Fields]) AND illumina[All Fields]) AND ("library layout paired"[Properties] AND "strategy wgs"[Properties] OR "strategy wga"[Properties] OR "strategy wcs"[Properties] OR "strategy clone"[Properties] OR "strategy finishing"[Properties] OR "strategy validation"[Properties] AND "filetype fastq"[Properties])

#filtered to 0-5G, and library selection random 

#selected 10 that were around 1G and downloaded the metadata

#stingless bee from Costa Rica from University of California Riverside

#use filezilla to move SraRunTable_7.csv to data directory 

nano 01_download_data

#get fasterq-dump

nano 01_download_data.sh

export PATH=$PATH:/sciclone/home/selozina/programs/sratoolkit.3.2.1-ubuntu64/bin

export PATH=$PATH:/sciclone/home/selozina/programs

mkdir -p ./data/raw

mkdir -p ./data/dog_reference

#get accession numbers and put into a txt file
cut -d',' -f1 data/SraRunTable_7.csv | tail -n +2 > data/accession.txt

for bee_data in $(cat data/accession.txt); do echo “downloading ${bee_data}”; fasterq-dump ${bee_data} -O data/raw; done

#download the dog data with datasets

datasets download genome taxon "Canis lupus familiaris" --reference --filename ./data/dog_reference/dog.zip; unzip ./data/dog_reference/dog.zip -d ./data/dog_reference

#clean up and rename file 

mv ./data/dog_reference/ncbi_dataset/data/GCF_011100685.1/GCF_011100685.1_UU_Cfam_GSD_1.0_genomic.fna ./data/dog_reference/dog_reference_genome.fna

rm -rf ./data/dog_reference/ncbi_dataset/ ./data/dog_reference/README.md ./data/dog_reference/dog.zip ./data/dog_reference/md5sum.txt


# Task 3

nano 02_clean_reads.sh

#!/bin/bash

set -euo pipefail

export PATH=$PATH:/sciclone/home/selozina/programs

mkdir -p ./data/clean 

for FWD_IN in ./data/raw/*_1.fastq; do REV_IN=${FWD_IN/_1.fastq/_2.fastq}; FWD_OUT=${FWD_IN/.fastq/_clean.fastq}; REV_OUT=${REV_IN/.fastq/_clean.fastq}; fastp --in1 ${FWD_IN} --in2 ${REV_IN} --out1 ${FWD_OUT} --out2 ${REV_OUT} --json /dev/null --html /dev/null --average_qual 20; done

mv ./data/raw/*_clean.fastq ./data/clean/

#make test files

head -n 8 ./data/raw/SRR27174686_1.fastq > ./data/raw/test/SRR27174686_1.fastq
head -n 8 ./data/raw/SRR27174689_1.fastq > ./data/raw/test/SRR27174689_1.fastq
head -n 8 ./data/raw/SRR27174686_2.fastq > ./data/raw/test/SRR27174686_2.fastq
head -n 8 ./data/raw/SRR27174689_2.fastq > ./data/raw/test/SRR27174689_2.fastq


for FWD_IN in ./data/raw/test/*_1.fastq; do REV_IN=${FWD_IN/_1.fastq/_2.fastq}; FWD_OUT=${FWD_IN/.fastq/_clean.fastq}; REV_OUT=${REV_IN/.fastq/_clean.fastq}; fastp --in1 ${FWD_IN} --in2 ${REV_IN} --out1 ${FWD_OUT} --out2 ${REV_OUT} --json /dev/null --html /dev/null --average_qual 20; done

#used defaults

mv ./data/raw/test/*_clean.fastq ./data/clean


# Task 4 & 5

#!/bin/bash

set -euo pipefail

export PATH=$PATH:/sciclone/home/selozina/programs/bbmap

export PATH=$PATH:/sciclone/home/selozina/programs/samtools-1.22.1

REF="./data/dog_reference/dog_reference_genome.fna"

mkdir -p output

for bee in ./data/clean/*_1_clean.fastq; do ACC=${bee/_1_clean.fastq/}; ACC=${ACC#./data/clean/}; bbmap.sh ref=${REF} in1=${bee} in2=${bee/_1_clean.fastq/_2_clean.fastq} out=./output/${ACC}.sam minid=0.95;done

#get data that matched dog genome 

for sam_view in ./output/*.sam; do ACC=${sam_view#./output/}; ACC=${ACC%.sam}; samtools view -F 4 ${sam_view} > ./output/${ACC}_mapped_to_dog.sam; done


# Task 6 

nano assignment_07_pipeline.slurm

#!/bin/bash
#SBATCH --job-name=assignment_07
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=10:00:00
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --mail-user=selozina@wm.edu
#SBATCH -o /sciclone/home/selozina/BIOCOMPUTING/assignments/assignment_07/output/assignment_07.out
#SBATCH -e /sciclone/home/selozina/BIOCOMPUTING/assignments/assignment_07/output/assignment_07.err

set -euo pipefail

mkdir -p output

./scripts/01_download_data.sh

./scripts/02_clean_reads.sh

./scripts/03_map_reads.sh

#removed all data and test outputs

sbatch assignment_07_pipeline.slurm


#did not give enough time for last two accessions and the view

#submitted another job

nano backup.slurm
 
#!/bin/bash
#SBATCH --job-name=assignment_07_2
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=10:00:00
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --mail-user=selozina@wm.edu
#SBATCH -o /sciclone/home/selozina/BIOCOMPUTING/assignments/assignment_07/output/assignment_07_2.out
#SBATCH -e /sciclone/home/selozina/BIOCOMPUTING/assignments/assignment_07/output/assignment_07_2.err

set -euo pipefail

export PATH=$PATH:/sciclone/home/selozina/programs/bbmap

export PATH=$PATH:/sciclone/home/selozina/programs/samtools-1.22.1

REF="./data/dog_reference/dog_reference_genome.fna"

bbmap.sh ref=${REF} in1=./data/clean/SRR27174712_1_clean.fastq  in2=./data/clean/SRR27174712_2_clean.fastq  out=./output/SRR27174712.sam  minid=0.95

bbmap.sh ref=${REF} in1=./data/clean/SRR27174715_1_clean.fastq  in2=./data/clean/SRR27174715_2_clean.fastq  out=./output/SRR27174715.sam  minid=0.95


for sam_view in ./output/*.sam; do ACC=${sam_view#./output/}; ACC=${ACC%.sam}; samtools view -F 4 ${sam_view} > ./output/${ACC}_mapped_to_dog.sam; done


# Task 8

nano 04_dog_mapped

#!/bin/bash

echo -e "Accession\tTotal_Reads\tDog_Mapped_Reads"

for bee in output/*.sam; do [[ ${bee} == *_mapped_to_dog.sam ]] && continue; acc=$(basename ${bee} .sam); total=$(grep -vc "^@" ${bee}); mapped=$(grep -v "^@" output/${acc}_mapped_to_dog.sam | wc -l); echo -e "${acc}\t${total}\t${mapped}"; done

#output

Accession	Total_Reads	Dog_Mapped_Reads
SRR27174686	26438840	6019
SRR27174689	25735702	20606
SRR27174696	27396496	18133
SRR27174701	24737170	10674
SRR27174702	27467458	16595
SRR27174708	23159196	7930
SRR27174710	23886670	57874
SRR27174711	32305188	6110
SRR27174712	30751534	40856
SRR27174715	32505100	131510

#add to .gitignore 

find ./assignments -name "*.sam" >> .gitignore

find ./asssignments -name "*.fastq" >> .gitignore


#Reflection

In this assignment, I downloaded 10 bee shotgun metagenome samples from the NCBI database then I downloaded the dog reference genome with the goal of determining if my bee samples were contaminated with dog dna! I first cleaned the data using fastp, then mapped my bee reads against the dog reference genome, and extracted the reads that matched the dog reference genome! There was a fairly high abundance of dog DNA in my samples! 

I have in the output directory, the error and output files and the .sam files from bbmap and samtools. In the data directory I have directories for the raw data, the cleaned data from fastp, and the dog_reference genome. 

This pipeline downloads bee metagenome data, the dog reference genome, and aims to determine if the samples were contaminated with dog DNA!

To run this pipeline, have datasets, sra-toolkit, bbmap, and samtools in your path or set up an environment that would enable you to use those. Also it is recommended that you request at least 15-16 hours on the SLURM when submitting the job using sbatch. The pipeline script is the script that is submitted to SLURM.

The first three scripts are ran in the pipeline, but the 4th script is simply to output a table of the number of reads that were mapped in total and to the dog reference genome per each sample.

One challenge that I had to overcome was not allotting enough time initially for my pipeline script to run on SLURM, which caused me to submit a following script (after the HPC was working again). Going forward, I plan to allot at least one day for each job to avoid having to overwrite or waste time. Additionally I will implement if statements to avoid overwriting in the future. I was lucky in that my script (if having proper time) worked first try! But I strongly accredit that to my extensive practice testing on small mock samples. 
