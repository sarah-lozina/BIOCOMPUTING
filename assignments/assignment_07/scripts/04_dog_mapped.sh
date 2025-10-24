#!/bin/bash

echo -e "Accession\tTotal_Reads\tDog_Mapped_Reads"

for bee in output/*.sam; do [[ "$bee" == *_mapped_to_dog.sam ]] && continue; acc=$(basename "$bee" .sam); total=$(grep -vc "^@" "$bee"); mapped=$(grep -v "^@" "output/${acc}_mapped_to_dog.sam" | wc -l); echo -e "${acc}\t${total}\t${mapped}"; done
