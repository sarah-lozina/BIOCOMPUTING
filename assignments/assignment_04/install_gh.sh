#!/bin/bash

cd 

cd programs/

#get the file
wget https://github.com/cli/cli/releases/download/v2.74.2/gh_2.74.2_linux_amd64.tar.gz

#unpack a gzipped tarball
tar -xzvf gh_2.74.2_linux_amd64.tar.gz 

#remove the downloaded tarball once extracted
rm gh_2.74.2_linux_amd64.tar.gz

cd 
