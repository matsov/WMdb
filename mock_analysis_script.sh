#!/bin/bash
#Mock basic analysis script
#Run in Ubuntu - CentOS 7 os

ID="MOCK1 MOCK2 MOCK3 MOCK4 MOCK5"

for s in ${ID}
do

cd ${s}
echo inside ${s}
sleep 3

mkdir -p benchmarking_${s}
mkdir -p benchmarking_${s}/VS_SILVA
mkdir -p benchmarking_${s}/VS_GG
mkdir -p benchmarking_${s}/VS_NCBI
mkdir -p benchmarking_${s}/VS_WMDB
mkdir -p benchmarking_${s}/BL_SILVA
mkdir -p benchmarking_${s}/BL_GG
mkdir -p benchmarking_${s}/BL_NCBI
mkdir -p benchmarking_${s}/BL_WMDB
mkdir -p benchmarking_${s}/NB_SILVA
mkdir -p benchmarking_${s}/NB_GG
mkdir -p benchmarking_${s}/NB_NCBI
mkdir -p benchmarking_${s}/NB_WMDB
mkdir -p benchmarking_${s}/BWA_WM

echo
echo 'Activating QIIME2 environment'
source activate qiime2-2021.11

pwd
#### VSEARCH

echo
echo 'running VSEARCH with SILVA'
qiime feature-classifier classify-consensus-vsearch --i-query rep_seqs.qza --i-reference-reads ~your_wd/SILVA_132/silva_132_99_16S.fna.qza --i-reference-taxonomy ~your_wd/SILVA_132/silva_132_taxonomy.qza --p-top-hits-only --p-maxaccepts 1 --p-unassignable-label 'Unassigned' --p-threads 30 --o-classification benchmarking_${s}/VS_SILVA/joined_dada2_rep_taxonomy.qza

echo
echo 'running VSEARCH with GREENGENES'
qiime feature-classifier classify-consensus-vsearch --i-query rep_seqs.qza --i-reference-reads ~your_wd/GREENGENES/gg_13_5.fasta.qza --i-reference-taxonomy ~your_wd/GREENGENES/gg_13_5_taxonomy.qza --p-top-hits-only --p-maxaccepts 1 --p-unassignable-label 'Unassigned' --p-threads 30 --o-classification benchmarking_${s}/VS_GG/joined_dada2_rep_taxonomy.qza

echo
echo 'running VSEARCH with NCBI'
qiime feature-classifier classify-consensus-vsearch --i-query rep_seqs.qza --i-reference-reads ~your_wd/ncbi_blast16S_May2022.qza --i-reference-taxonomy ~your_wd/ncbi_blast16S_taxonomy_May2022.qza --p-top-hits-only --p-maxaccepts 1 --p-unassignable-label 'Unassigned' --p-threads 30 --o-classification benchmarking_${s}/VS_NCBI/joined_dada2_rep_taxonomy.qza

echo
echo 'running VSEARCH with WMDB'
qiime feature-classifier classify-consensus-vsearch --i-query rep_seqs.qza --i-reference-reads ~your_wd/WMDB_BWA/WMDB_bwa_sequences_qiime2.qza --i-reference-taxonomy ~your_wd/WMDB_BWA/WMDB_bwa_taxonomy_qiime2.qza --p-top-hits-only --p-maxaccepts 1 --p-unassignable-label 'Unassigned' --p-threads 30 --o-classification benchmarking_${s}/VS_WMDB/joined_dada2_rep_taxonomy.qza


#### BLAST

echo
echo 'running BLAST with SILVA'
qiime feature-classifier classify-consensus-blast --i-query rep_seqs.qza --i-reference-reads ~your_wd/SILVA_132/silva_132_99_16S.fna.qza --i-reference-taxonomy ~your_wd/SILVA_132/silva_132_taxonomy.qza --p-maxaccepts 1 --o-classification benchmarking_${s}/BL_SILVA/joined_dada2_rep_taxonomy.qza

echo
echo 'running BLAST with GREENGENES'
qiime feature-classifier classify-consensus-blast --i-query rep_seqs.qza --i-reference-reads ~your_wd/GREENGENES/gg_13_5.fasta.qza --i-reference-taxonomy ~your_wd/GREENGENES/gg_13_5_taxonomy.qza --p-maxaccepts 1 --o-classification benchmarking_${s}/BL_GG/joined_dada2_rep_taxonomy.qza

echo
echo 'running BLAST with NCBI'
qiime feature-classifier classify-consensus-blast --i-query rep_seqs.qza --i-reference-reads ~your_wd/ncbi_blast16S_May2022.qza --i-reference-taxonomy ~your_wd/ncbi_blast16S_taxonomy_May2022.qza --p-maxaccepts 1 --o-classification benchmarking_${s}/BL_NCBI/joined_dada2_rep_taxonomy.qza

echo
echo 'running BLAST with WMDB'
qiime feature-classifier classify-consensus-blast --i-query rep_seqs.qza --i-reference-reads ~your_wd/WMDB_BWA/WMDB_bwa_sequences_qiime2.qza --i-reference-taxonomy ~your_wd/WMDB_BWA/WMDB_bwa_taxonomy_qiime2.qza --p-maxaccepts 1 --o-classification benchmarking_${s}/BL_WMDB/joined_dada2_rep_taxonomy.qza


#### BAYESIAN

echo
echo 'NB with SILVA'
qiime feature-classifier classify-sklearn --i-classifier ~your_wd/SILVA_132/silva_132_bayeisn_classifier.qza --i-reads rep_seqs.qza --o-classification benchmarking_${s}/NB_SILVA/joined_dada2_rep_taxonomy.qza

echo
echo 'NB with GG'
qiime feature-classifier classify-sklearn --i-classifier ~your_wd/GREENGENES/gg_bayesian_classifier.qza --i-reads rep_seqs.qza --o-classification benchmarking_${s}/NB_GG/joined_dada2_rep_taxonomy.qza

echo
echo 'NB with NCBI'
qiime feature-classifier classify-sklearn --i-classifier ~your_wd/ncbi_blast_bayesian_classifier.qza --i-reads rep_seqs.qza --o-classification benchmarking_${s}/NB_NCBI/joined_dada2_rep_taxonomy.qza

echo
echo 'NB with WMDB'
qiime feature-classifier classify-sklearn --i-classifier wmdb_classifier.qza --i-reads rep_seqs.qza --o-classification benchmarking_${s}/NB_WMDB/joined_dada2_rep_taxonomy.qza



#### WM METHOD with WM database
#OMITTED#

done
