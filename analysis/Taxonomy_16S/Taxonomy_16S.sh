#!/usr/bin/bash
#Workflow to 16S taxonomy analysis by Rafael Lopez Sanchez.Pipeline used

#We use the pipeline of Parallel-Meta v.2.4.1 
parallel-meta -b B -r flash_out.extendedFrags.fasta -d X -n 4

## Transform the taxonomy.txt file into an abundance matrix. We use the taxonomy2lineage.sh from Dr Grisel Alejandra Escobar Zepeda.
$taxonomy2lineage.sh 

## Integramos todas las matrices en una sola. El script que lo hace es /home/ales/scripts/matrix_integrator_bmk.pl
## Vamos a ponerla en una carpeta aparte
$ mkdir integrated_matrix && cd integrated_matrix

## Hacemos ligas simbolicas de todos los resultados y corremos el programa
$ mv ../names.file .
$ for cosa in $(cat names.file); do (ln -s ../$cosa/Result/taxonomy2lineage.txt $cosa); done
$ /home/ales/scripts/matrix_integrator_bmk.pl names.file
$ less integrated_matrix.txt

## ¿Tenemos anotacion para dominios que no sean Bacteria o Archaea? ¿Cuantos son? Nos conviene eliminarlos
$ cut -d ';' -f1 integrated_matrix.txt | sort | uniq
$ grep -c '^Chloroplast' integrated_matrix.txt
$ grep -c '^Eukaryota' integrated_matrix.txt
$ sed '/^Chloroplast/d;/^Eukaryota/d' integrated_matrix.txt> proka_integrated_matrix.txt
