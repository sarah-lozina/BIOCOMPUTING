#!/bin/bash

echo -e "Accession\tTotal_Reads\tDog_Mapped_Reads"

for bee in $(find ${HOME}/scr10/assignment_07/output/ -name "*.sam" ! -name "*_mapped_to_dog.sam"); do acc=$(basename ${bee} .sam); total=$(grep -vc "^@" ${bee}); mapped=$(grep -vc "^@" "${HOME}/scr10/assignment_07/output/${acc}_mapped_to_dog.sam"); echo -e "${acc}\t${total}\t${mapped}"; done
