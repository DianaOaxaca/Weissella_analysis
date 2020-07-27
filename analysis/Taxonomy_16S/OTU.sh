#!/usr/bin/bash
#Workflow to 16S OTUs analysis by Rafael Lopez Sanchez. 

#1. Reconstruction of the original amplicon of the regions V3-V4 (~450bp).
$ flash -r 300 -f 450 -s 30 -t 2 -o flash_out *R1.fastq *R2.fastq

#2. Convert the extended frags from fastq format to fasta. 
$ awk 'NR%4==1{gsub("@",">");print} NR%4==2{print}' flash_out.extendedFrags.fastq > flash_out.extendedFrags.fasta); done

#2.1 Modify header using the script modifHeaderSimpleSample.pl made by Dr. Grisel Alejandra Escobar Zepeda
$ modifHeaderSimpleSample.pl flash_out.extendedFrags.fasta

# 3. Desreplicate sequences to 100% of identity.
$ vsearch --derep_fulllength $file --output $sequence_derep --sizeout --strand both --threads 8
  
# 4. Eliminate chimeras 
$vsearch --uchime_denovo sequence_derep --nonchimeras sequence_nonchim.fasta --threads 8
 
## 5. Cluster sequence into OTUs with 97% similarity of identity. 
$ vsearch --cluster_fast nonchim_all.fasta --id 0.97 --sizein --sizeout --strand both --threads 8 --otutabout otu_table.txt

# 6. Filter singletones with the script singletones_filter.pl made by Dr. Grisel Alejandra Escobar Zepeda on the otu_table.txt
$ singletones_filter.pl otu_table.txt
