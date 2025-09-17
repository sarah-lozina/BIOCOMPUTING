Sarah Lozina 0918 Assignment 3

In task 1 I created the data directory and README.md file in the assignment_03 directory that I needed for the assignment and in task 2 I downloaded the file GCF_000001735.4_TAIR10.1_genomic.fna.gz and unzipped it. Then in task 3 I completed various tasks to explore the genome assembly for A. thalliana such as counting the number of sequences, number of nucleotides, number of lines containing certain key words, etc. In task 4 I completed my README.md file and in task 5 I wrote a reflection on my experience completing this assignment.


# Task 1


bora #alias

cd BIOCOMPUTING/assignments/

mkdir assignment_0{3..8} 

cd assignment_03

mkdir data
 
touch README.md


# Task 2


cd data

wget https://gzahn.github.io/data/GCF_000001735.4_TAIR10.1_genomic.fna.gz 

gunzip GCF_000001735.4_TAIR10.1_genomic.fna.gz


# Task 3


cat GCF_000001735.4_TAIR10.1_genomic.fna.gz #look at file, lot of gene sequences

#mix of capital and lowercase


#1: how many sequences are in the file

cat GCF_000001735.4_TAIR10.1_genomic.fna | grep "^>"| wc -l #in class used to determine the number of sequences 


#2: What is the total number of nucleotides (not including header lines or newlines)

grep -v "^>" GCF_000001735.4_TAIR10.1_genomic.fna | tr -d "\n" | wc -c  #get every line that is not a header | remove new lines | count the number of nucleotides (characters)


#3: How many total lines are in the file

wc -l GCF_000001735.4_TAIR10.1_genomic.fna


#4: How many header lines contain the word "mitochondrion"

grep -c "mitochondrion" GCF_000001735.4_TAIR10.1_genomic.fna


#5: How many header lines contain the word "chromosome”
grep -c "chromosome" GCF_000001735.4_TAIR10.1_genomic.fna 


#6: How many nucleotides are in each of the first 3 chromosome sequences

grep “chromosome” GCF_000001735.4_TAIR10.1_genomic.fna  #look at the headers

grep -n "^>.*chromosome" GCF_000001735.4_TAIR10.1_genomic.fna #get the line numbers

head -n 2 GCF_000001735.4_TAIR10.1_genomic.fna | tail -n +2 | wc -c

head -n 4 GCF_000001735.4_TAIR10.1_genomic.fna | tail -n +3 | grep -v "^>" | wc -c

head -n 6 GCF_000001735.4_TAIR10.1_genomic.fna | tail -n +5  | grep -v "^>" | wc -c 


#7: How many nucleotides are in the sequence for 'chromosome 5'

grep -n "^>.*chromosome" GCF_000001735.4_TAIR10.1_genomic.fna #get the line numbers 

head -n 10 GCF_000001735.4_TAIR10.1_genomic.fna | tail -n +9  | grep -v "^>" | wc -c 


#8: How many sequences contain "AAAAAAAAAAAAAAAA"

cat GCF_000001735.4_TAIR10.1_genomic.fna | grep "AAAAAAAAAAAAAAAA" | wc -l


#9:If you were to sort the sequences alphabetically, which sequence (header) would be first in that list

grep "^>" GCF_000001735.4_TAIR10.1_genomic.fna | sort | head -n 1



#10: How would you make a new tab-separated version of this file, where the first column is the headers and the second column are the associated sequences

paste <(grep -i ">" GCF_000001735.4_TAIR10.1_genomic.fna) <(grep -i ">" GCF_000001735.4_TAIR10.1_genomic.fna -v) > new_tsv.txt #did this one with help from groupchat :)



# Task 4 


bora

cd /BIOCOMPUTING/assignments/assignment_03 #navigate to assignment_03

nano README.md

ctrl o enter ctrl x

exit
#go to filezilla and drag BIOCOMPUTING from HPC to local BIOCOMPUTING

#go back to terminal

cd BIOCOMPUTING

git add .

git commit -m"Add Assignment 3: Exploring DNA sequence file with command line tools"

git push


# Task 5: Reflection


My approach for this assignment was to try different approaches and utilize various online resources (ex GeeksforGeeks) that provided different ways to use the basic commands we used in class. Additionally, I reviewed my notes from the past two classes and applied some of those workflows to the problems in task 3. I wanted to use this assignment as a way to practice and test myself to see what I remembered without looking at my notes first, and then going to my notes or other sources if I needed to. Additionally, as the assignment went on, I got better at recognizing when I could reuse/slightly tweak a workflow to achieve the results required. 

This assignment improved my understanding of grep and the wide variety of tasks it can accomplish. Additionally, this assignment helped me learn how helpful different flags can be in accomplishing tasks. I started a document in my notes to catalog various flags and what they can help with using various commands. Question 6 was the most frustrating for me because I figured out how to get the line numbers, but I had issues getting the correct nucleotide count. 

These kinds of skills are essential to computational biology because they allow for the researcher to quickly navigate files and make sense of large datasets efficiently. Many of the commands I implemented today assist with making sense and gathering only the relevant information for a task by getting pieces of information from large genomic datasets. This ability to filter through and manipulate large amounts of data efficiently allows analyses to be conducted and conclusions to be drawn faster and more accurately. Additionally, these skills support reproducibility because if you keep track of your steps, the results should always be the same if implemented by someone else. Additionally, through writing scripts, workflows can be applied to multiple datasets, which speeds up the research process.
