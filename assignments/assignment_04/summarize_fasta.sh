#!/bin/bash

#accepts the name of a fasta file as a positional argument and stores that filename in a variable
fasta_file=${1}

#the total number of sequences
total_sequences=$(seqtk size ${fasta_file} | cut -f1)

#the total number of nucleotides 
total_nucleotides=$(seqtk size ${fasta_file} | cut -f2)

#a table of sequence names and lengths
table=$(seqtk comp ${fasta_file} | cut -f1,2)

#reports the information to stout 
echo "${fasta_file}"
echo "Total Sequences: ${total_sequences}"
echo "Total Nucleotides: ${total_nucleotides}"
echo -e "Table of Sequence Names and Lengths:\n${table}"
