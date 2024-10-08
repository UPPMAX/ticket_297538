#!/bin/bash
module load python/3.8.7

pip install triton
pip install cmake

# Folder where DNABERT2 will be installed in
DNABERT_2_SUPERFOLDER=/proj/staff/richel
# DNABERT_2_SUPERFOLDER=/home/richel

(
  cd "${DNABERT_2_SUPERFOLDER}" || exit
  git clone https://github.com/MAGICS-LAB/DNABERT_2
  cd DNABERT_2 || exit
  python3 -m pip install -r requirements.txt
)

./run.sh
