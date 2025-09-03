
## Navigate
 
cd BIOCOMPUTING/
ls #check to make sure in biocomputing
cd assignments
cd assignment_01/ #get into assignment 1
ls #see data, output, README.md and scripts made in class

## Make Directories and Files in Assignment 1

Mkdir results notes settings #add results, notes, settings
#now have data, notes, output, README.md, results, scripts
touch assignment_1_essay.md #make essay file
ls #all files and directories expect 
mkdir -p data/raw data/clean #make raw and clean directories in data 
cd data
ls #check that see clean and raw in data directory

##Add Sample Files to each Directory

Touch clean/clean_example.txt raw/raw_example.txt #while in data, create example clean and raw files
#check present
cd clean 
ls 
cd ..
cd raw 
ls
cd ../.. #return to assignment_01 
touch notes/notes_example.txt output/output_example.txt results/results_example.txt scripts/scripts_example.txt settings/settings_example.txt  #add example files to notes, output, results, scripts, and settings
cd notes
ls #check notes to see if notes_example.txt present
cd .. #get back to assignment_01

##Updating assignment_1_essay.md

nano assignment_1_essay.md
#so I could keep track of wordcount,I wrote my essay on a google doc and pasted it into the file one paragraph at a time
Ctrl O
Enter
Ctrl X

##Updating README.md

nano README.md
Ctrl O
Enter
Ctrl X

##Pushing to GitHub
git add .
git commit -m "Add Assignment 1: Project Structure and Rationale"
git push
