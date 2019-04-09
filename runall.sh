#!/bin/bash

module load bbtools

# Use BBtools to demultiplex  files based on the headers
for file in *_R1.fastq.gz
  do
      bname=`basename $file _R1.fastq.gz`
      demuxbyname.sh in=$file in2=${bname}_R2.fastq.gz delimiter=colon column=10 out=${bname}_%_R1.fastq.gz out2=${bname}_%_R2.fastq.gz
  done

# cpy origional data to a new folder
mkdir original
mv L_Feed_R* original
mv 16S_Feed_R* original
mv L_Water_R* original
mv L_Gut_R* original
mv 16S_Water_R* original
mv 16S_Gut_R* original

# create the manifest
ls *.fastq.gz > filenames.txt
python filenames_2_manifest.py > manifest.txt
# 16S and LSU should be processed separatly, split them now
head -n1 manifest.txt > 16S_manifest.txt
head -n1 manifest.txt > LSU_manifest.txt
grep "LSU" manifest.txt >> LSU_manifest.txt
grep "16S" manifest.txt >> 16S_manifest.txt

source activate /project/gbru/gbru_fy18_candis/qiime2-2019.1

qiime tools import --type 'SampleData[PairedEndSequencesWithQuality]' \
                   --input-format PairedEndFastqManifestPhred33 \
                   --input-path 16S_manifest.txt \
                   --output-path 16S_demuxed.qza

qiime tools import --type 'SampleData[PairedEndSequencesWithQuality]' \
                   --input-format PairedEndFastqManifestPhred33 \
                   --input-path LSU_manifest.txt \
                   --output-path LSU_demuxed.qza

time qiime demux summarize \
  --i-data 16S_demuxed.qza \
  --o-visualization 16S_demuxed.qzv

time qiime demux summarize \ß
    --i-data LSU_demuxed.qza \
    --o-visualization LSU_demuxed.qzv

qiime dada2 denoise-paired --i-demultiplexed-seqs LSU_demuxed.qza \
                           --p-trunc-len-f 220 \
                           --p-trunc-len-r 150 \
                           --p-n-threads 38 \
                           --p-n-reads-learn 1000000 \
                           --output-dir dada2_LSU \
                           --verbose

qiime dada2 denoise-paired --i-demultiplexed-seqs 16S_demuxed.qza \
                          --p-trunc-len-f 275 \
                          --p-trunc-len-r 240 \
                          --p-n-threads 38 \
                          --p-n-reads-learn 1000000 \
                          --output-dir dada2_16S \
                          --verbose
