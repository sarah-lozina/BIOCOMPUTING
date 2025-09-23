##  Sarah Lozina 9/25 Assignment 4: Bash scripts and program PATHs


# Task 1 

#already done in class, but checked 

bora

ls #see programs directory

cd programs/

ls #see the do_stuff.sh and the first_last.sh


# Task 2

cd programs

#get the file
wget https://github.com/cli/cli/releases/download/v2.74.2/gh_2.74.2_linux_amd64.tar.gz

#unpack a gzipped tarball
tar -xzvf gh_2.74.2_linux_amd64.tar.gz 

#remove the downloaded tarball once extracted
rm gh_2.74.2_linux_amd64.tar.gz


# Task 3

cd BIOCOMPUTING

cd assignments

cd assignment_04

nano install_gh.sh

chmod +x install_gh.sh


# Task 4

#delete old 

rm -rf gh_2.74.2_linux_amd64/

./install_gh.sh


# Task 5

#navigate to bin

pwd

cd ~

nano .bashrc

export PATH=$PATH:/sciclone/home/selozina/programs/gh_2.74.2_linux_amd64/bin


# Task 6 

gh auth login 

#GitHub.com

#HTTPS

#Yes

#Paste an authentication token


# Task 7

cd programs/

git clone https://github.com/lh3/seqtk.git;
cd seqtk; make

cd seqtk

pwd #/sciclone/home/selozina/programs/seqtk

cd ~

cd BIOCOMPUTING/assignments/assignment_04

chmod +x install_seqtk_2.sh 

nano install_seqtk_2.sh

source ~/.bashrc

#also to confirm that can push from the HPC pushed assignment_04 directory and the scripts

git pull

git add assignments/assignment_04/

git commit -m”pushing from the HPC”

git push 

#note had issues with original install_seqtk.sh file so made and used install_seqtk_2.sh. ignore the install_seqtk.sh file accidentally pushed to the assignment_04 directory on github. 


# Task 8 

#working ahead a bit, but made copies of fasta file from assignment 3

cd ~/BIOCOMPUTING/assignments/assignment_03/data/

#make 3 copies
cp GCF_000001735.4_TAIR10.1_genomic.fna GCF_000001735.4_TAIR10.1_genomic1.fna

cp GCF_000001735.4_TAIR10.1_genomic.fna GCF_000001735.4_TAIR10.1_genomic2.fna

cp GCF_000001735.4_TAIR10.1_genomic.fna GCF_000001735.4_TAIR10.1_genomic3.fna

#realized could make this with a for loop too after the fact

#move the three files to the assignment_04 directory 
mv GCF_000001735.4_TAIR10.1_genomic{1,2,3}.fna ../../assignment_04/

#added these file names to .gitignore before forget to

cd ~

nano .gitignore 

seqtk #see what can do 

seqtk size GCF_000001735.4_TAIR10.1_genomic1.fna 

#output is 7 and 119668634, which from our assignment_03 is the number of sequences and number of nucleotides

seqtk comp GCF_000001735.4_TAIR10.1_genomic1.fna #outputs sequence names and lengths


# Task 9

nano summarize_fasta.sh 

#!/bin/bash

fasta_file=${1}

total_sequences=$(seqtk size ${fasta_file} | cut -f1)

total_nucleotides=$(seqtk size ${fasta_file} | cut -f2)

table=$(seqtk comp ${fasta_file} | cut -f1,2)

echo "${fasta_file}"

echo "Total Sequences: ${total_sequences}"

echo "Total Nucleotides: ${total_nucleotides}"

echo -e "Table of Sequence Names and Lengths:\n${table}"

#test 
./summarize_fasta.sh GCF_000001735.4_TAIR10.1_genomic1.fna #output is what wanted!


# Task 10

#got the three fasta files earlier: GCF_000001735.4_TAIR10.1_genomic{1..3}.fna 

for i in *_genomic*; do ./summarize_fasta.sh ${i};sleep 2;done


# Task 11

#edited the README.md


# Task 12

git pull 

git add 

git commit -m”Add Assignment 4: Bash scripts and program PATHs”

git push

# Reflection

Tasks 1-6 went pretty smoothly, but task 7 was tricky because I think I may have had a typo in my script that would not install seqtk and add it to my .bashrc properly. Eventually, I decided to just make a new script and rewrite the code which worked! This taught me that sometimes just starting fresh is the best course of action! The rests of the tasks went pretty well and I enjoyed being a detective and trying to figure out what every seqtk command would output! I also finally used a text editor instead of google docs for my notes, which definitely made this part easier! Some new things I learned were how to do a git pull, how to use .gitignore, and what seqtk does. Additionally, my confidence writing scripts and for loops was improved! $PATH is an environment variable that lists directories the system searches for executable files when a command is entered. This allows us to run commands, scripts, and programs from any directory without typing the full path! To view $PATH I can type echo $PATH.
