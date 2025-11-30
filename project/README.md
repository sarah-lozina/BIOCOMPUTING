## Final Project: Parkinson's vs Control Gut Microbiomes

# Sarah Lozina


# Parkinson's Samples

ERR1912976
ERR1913073
ERR1913059
ERR1912964
ERR1913119

# Control Samples

ERR1913016
ERR1913108
ERR1913060
ERR1913044
ERR1913110

Part of pipeline I changed: fastp parameters -l 75 and -e 25 

for fwd in ${DL_DIR}/*_1.fastq.gz;do rev=${fwd/_1.fastq.gz/_2.fastq.gz};outfwd=${fwd/.fastq.gz/_qc.fastq.gz};outrev=${rev/.fastq.gz/_qc.fastq.gz};fastp -i $fwd -o $outfwd -I $rev -O $outrev -j /dev/null -h /dev/null -n 0 -l 75 -e 25;done

