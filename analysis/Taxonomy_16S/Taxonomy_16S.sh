#!/usr/bin/bash
#Workflow to 16S taxonomy analysis by Rafael Lopez Sanchez. Pipeline used

#1. pipeline of Parallel-Meta v.2.4.1 
parallel-meta -b B -r flash_out.extendedFrags.fasta -d X -n 4

#2.Transform the taxonomy.txt file into an abundance matrix with the name taxonomy2lineage.txt. We use the taxonomy2lineage.sh from Dr Grisel Alejandra Escobar Zepeda.
./taxonomy2lineage.sh 

#.3 Integrate the taxonomy2lineage.txt files into a matrix using the matrix_integrator_bmk.pl script written by Dr Grisel Alejandra Escobar Zepeda and a list file of the folders called name.file.
matrix_integrator_bmk.pl names.file

#4. Eliminate Eukaryota, and Chloroplast sequences from the integrated matrix.
$ cut -d ';' -f1 integrated_matrix.txt | sort | uniq
$ grep -c '^Chloroplast' integrated_matrix.txt
$ grep -c '^Eukaryota' integrated_matrix.txt
$ sed '/^Chloroplast/d;/^Eukaryota/d' integrated_matrix.txt> proka_integrated_matrix.txt
