#!/usr/bin/bash

#1. Merge the best assemblies with metassemble

metassemble --conf metassemble_WcL17.config
metassemble --conf metassemble_Wcp3a.config

#2. Scafolding with SSPACE
#2.1 File required by SSPACE

echo 'lib1 bwa w17_R1_val_1.fastq w17_R1_val_2.fastq 550 0.75 FR' > SSPACE_WcL17.config
echo 'lib1 bwa wp_R1_val_1.fastq wp_R1_val_2.fastq 550 0.75 FR' > SSPACE_Wcp3a.config

#2.2 Run SSPACE

SSPACE_Standard_v3.0.pl -l SSPACE_WcL17.config -s ../METASSEMBLE_WcL17/Metassembly/QB.A/M1/QB.A.ctgs.fasta -k 5 -a 0.7 -x 1 -m 32 -o 20 -n 15 -T 24 -b SSPACE_WcL17_Met
SSPACE_Standard_v3.0.pl -l SSPACE_Wcp3a.config -s ../METASSEMBLE_Wcp3a/Metassembly/QB.A/M1/QB.A.ctgs.fasta -k 5 -a 0.7 -x 1 -m 32 -o 20 -n 15 -T 24 -b SSPACE_Wcp3a_Met

#3. Gap delete

GapFiller.pl -l SSPACEwp.config -s SSPACE_WcL17_Met.final.scaffolds.fasta -m 29 -o 2 -d 50 -n 10 -t 10 -r 0.7 -i 10 -T 24 -b WcL17GF
GapFiller.pl -l SSPACEwp.config -s SSPACE_Wcp3a_Met.final.scaffolds.fasta -m 29 -o 2 -d 50 -n 10 -t 10 -r 0.7 -i 10 -T 24 -b WcpGF
