#!/bin/bash

set -ueo pipefail

cd ~

mkdir -p programs

cd programs

git clone https://github.com/fenderglass/Flye

cd Flye

make

