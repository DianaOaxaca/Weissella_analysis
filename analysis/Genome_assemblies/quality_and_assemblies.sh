#!/usr/bin/bash
#DianaOaxaca

#1. Quality control and reads cleaning

fastqc w17_R1.fastq w17_R2.fastq
fastqc wp_R1.fastq wp_R2.fastq

trim_galore --fastqc --illumina --paired --retain_unpaired  w17_R1.fastq w17_R2.fastq
trim_galore --fastqc --illumina --paired --retain_unpaired  wp_R1.fastq wp_R2.fastq

#2. Assemblies for WcL17 and WCP3a. Only the lines that originated the best assemblies for each genome are shown
#2.1 VelvetOptimiser calculation

VelvetOptimiser.pl --s 11 --e 71 --x 2 -f '-fastq -separate -shortPaired w17_R1_val_1.fq w17_R2_val_2.fq'
VelvetOptimiser.pl --s 11 --e 71 --x 2 -f '-fastq -separate -shortPaired wp_R1_val_1.fq wp_R2_val_2.fq'

#2.2.1 Run velvetg and velveth with WcL17 reads

velveth velvet_WcL17 65 -fastq -separate -shortPaired w17_R1_val_1.fq w17_R2_val_2.fq
velvetg velvet_WcL17/ -cov_cutoff auto -ins_length 550 -exp_cov auto

#2.2.2 Run velvetg and velveth with Wcp3a reads

velveth velvet_Wcp3a 61 -fastq -separate -shortPaired wp_R1_val_1.fq wp_R2_val_2.fq
velvetg velvet_Wcp3a/ -cov_cutoff auto -ins_length 550 -exp_cov auto

#2.3 SPAdes assemblies

spades.py --careful -1 w17_R1_val_1.fq -2 w17_R2_val_2.fq -k 11,33,55,61,65,71 -o spades_v3_WcL17
##For Wcp3a the best assemblies were did with SPAdes
spades.py --careful -1 wp_R1_val_1.fq -2 wp_R2_val_2.fq -k 33,43,55,61,71 -o spades_v1_Wcp3a
spades.py --careful -1 wp_R1_val_1.fq -2 wp_R2_val_2.fq -k 11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47,49,51,53,55,57,59,61,63,65,67,69,71,73,75 -o spades_v2_Wcp3a
