#!/bin/bash
#SBATCH --job-name=16sdada
#SBATCH --output=16sdada.out
#SBATCH --error=16sdada.err
#SBATCH --time=144:00:00
#SBATCH -p gbru
#SBATCH -N 1
#SBATCH -n 36

source activate /project/gbru/gbru_fy18_candis/qiime2-2019.1

qiime dada2 denoise-paired --i-demultiplexed-seqs 16S_demuxed.qza \
                          --p-trunc-len-f 275 \
                          --p-trunc-len-r 240 \
                          --p-n-threads 35 \
                          --p-n-reads-learn 1000000 \
                          --output-dir dada2_16S \
                          --verbose
