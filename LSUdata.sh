#!/bin/bash
#SBATCH --job-name=LSUdada
#SBATCH --output=LSUdada.out
#SBATCH --error=LSUsdada.err
#SBATCH --time=144:00:00
#SBATCH -p gbru-mem768
#SBATCH -N 1
#SBATCH -n 39

source activate /project/gbru/gbru_fy18_candis/qiime2-2019.1

qiime dada2 denoise-paired --i-demultiplexed-seqs LSU_demuxed.qza \
                           --p-trunc-len-f 220 \
                           --p-trunc-len-r 150 \
                           --p-n-threads 38 \
                           --p-n-reads-learn 1000000 \
                           --output-dir dada2_LSU \
                           --verbose
