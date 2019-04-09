#!/bin/bash

module load bbtools

for file in *_R1.fastq.gz
  do
      bname=`basename $file _R1.fastq.gz`
      demuxbyname.sh in=$file in2=${bname}_R2.fastq.gz delimiter=colon column=10 out=${bname}_%_R1.fastq.gz out2=${bname}_%_R2.fastq.gz
  done

mkdir original
mv L_Feed_R* original
mv 16S_Feed_R* original
mv L_Water_R* original
mv L_Gut_R* original
mv 16S_Water_R* original
mv 16S_Gut_R* original

python filenames_2_manifest.py > manifest.txt

source activate /project/gbru/gbru_fy18_candis/qiime2-2019.1

qiime tools import --type 'SampleData[PairedEndSequencesWithQuality]'' \ 
                   --input-format PairedEndFastqManifestPhred33 \
                   --input-path manifest.txt \
                   --output-path demuxed.qza
