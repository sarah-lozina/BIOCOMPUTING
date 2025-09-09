
Sarah Lozina 0911 assignment 2

In task 1 I set up my workspace on the HPC which is the same as my local git repo, but includes assignment_02 with a data directory and a README.md file.

In task 2 I downloaded two files from NCBI via ftp.

In task 3 I transfered the files to the HPC using FileZilla and then used chmod to make the files readable for everyone.

In task 4 I used md5sum to verify that the MD5 hashes were the same on my local machine and on the HPC (they were).

In task 5 I created three useful Bash aliases: u, d, and ll. u moves up one directory, clears the terminal screen, shows the current working directory, and lists the contents of the current directory. d switches back to the previous directory I was in and also clears, prints the current working directory, and lists the contents of the current directory. ll lists all the contents of the directory including hidden files, human-readable sizes, and directories first.

In task 6 I documented all of my commands and wrote a reflection. 

Here are my commands: 
#task 1

bora #alias 
mkdir -p ~/BIOCOMPUTING/{assignments,notes,projects,practice}
mkdir -p ~/BIOCOMPUTING/assignments/assignment_2/data
touch ~/BIOCOMPUTING/assignments/assignment_2/README.md

#got alert that have notes file so couldnt make directory
cd BIOCOMPUTING
mv notes notes_test #rename file
mkdir notes
#check
cd assignments
ls #see 01 and 02
cd assignment_02 #see data directory and README.md
exit

#task 2

brew install inetutils #to get ftp
ftp ftp.ncbi.nlm.nih.gov

#login
Anonymous
selozina@wm.edu
#get the files
passive
binary
cd genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/
get GCF_000005845.2_ASM584v2_genomic.fna.gz
get GCF_000005845.2_ASM584v2_genomic.gff.gz
bye
ls #see files in my home directory 

#task 3.1

#used FileZilla to drag the .gz files into the data directory in assignment_02
#command S
#host is bora.sciclone.wm.edu
#entered my username and password
#Port is 22
#Protocol is SFTP
#on right, HPC side navigated to data directory in assignment_02 in assignments in BIOCOMPUTING
#dragged each file one at a time over into data 
#task 3.2
#check files readable 
#go to the files 
bora
cd ~/BIOCOMPUTING/assignments/assignment_02/data
ls -l  #see two files
#both -rw-------.
#make readable for everyone 
chmod a+r GCF_000005845.2_ASM584v2_genomic.*.gz #all users read 

#task 4

#in HPC 
md5sum GCF_000005845.2_ASM584v2_genomic.*.gz 
#output: 
c13d459b5caa702ff7e1f26fe44b8ad7 GCF_000005845.2_ASM584v2_genomic.fna.gz
2238238dd39e11329547d26ab138be41 GCF_000005845.2_ASM584v2_genomic.gff.gz
exit
#in local 
md5sum GCF_000005845.2_ASM584v2_genomic.*.gz 
#output:
c13d459b5caa702ff7e1f26fe44b8ad7  GCF_000005845.2_ASM584v2_genomic.fna.gz
2238238dd39e11329547d26ab138be41 GCF_000005845.2_ASM584v2_genomic.gff.gz
#they match!

#task 5

#check to make sure have the aliases
bora
nano ~/.bashrc 
#added aliases
alias u='cd ..;clear;pwd;ls -alFh --group-directories-first'
alias d='cd -;clear;pwd;ls -alFh --group-directories-first'
alias ll='ls -alFh --group-directories-first' #had ll already
ctrl o enter ctrl x

#task 6

bora
#navigate to assignment_02
nano README.md
ctrl o enter ctrl x
exit

#go to filezilla and drag BIOCOMPUTING from HPC to local BIOCOMPUTING
#go back to terminal 
cd BIOCOMPUTING
git add .
git commit -m"Add Assignment 2: HPC Access & Remote File Transfer"
git push


#Reflection

I had no issues with task 1, besides realizing that I had created a notes file in my BIOCOMPUTING directory, so I had to rename the file and create the notes directory afterwards. In task 2, I encountered some issues connecting to the NCBI FTP server, but using online resources, I was able to determine that I needed to download inetutils to get ftp and use passive and binary to access it and keep the data intact. I had no issues with FileZilla, but realized I have to be on W&M wifi to log into it. By checking if the files were readable, I gained a better understanding of the meaning of the ls -l output. In task 4, my mdsum hashes matched on both my local and the HPC, so I had no issues there, and in task 5, I just had to update the aliases that I had added to bashrc in class.

