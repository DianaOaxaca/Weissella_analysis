#!/usr/bin/bash
#1. Compare assemblies with QUAST
quast.py 

#2. Coverage estimation with bowtie2
#2.1 Build index

bowtie2-build WcL17GF.gapfilled.final.fa WcL17GF.gapfilled.final.fa --threads 22
bowtie2-build Wcp3aGF.gapfilled.final.fa Wcp3aGF.gapfilled.final.fa --threads 22

#2.2 Mapping

bowtie2 -p 22 -x WcL17GF.gapfilled.final.fa -1 w17_R1_val_1.fq -2 w17_R2_val_2.fq -S WcL17.sam
bowtie2 -p 22 -x Wcp3aGF.gapfilled.final.fa -1 w17_R1_val_1.fq -2 w17_R2_val_2.fq -S Wcp3a.sam

#2.3 Calculation

#WcL17 mapping results:
	#6185922 (100.00%) were paired;
	#97.29% overall alignment rate
	# So:
expr 6185922 * 0.9729 
	# Result =  6018283.514

expr (6018283.514*75) / 2310516 
	# Result = 195.35 X

#Wcp3a mapping results:
	#7370348 (100.00%) were paired
        #97.28% overall alignment rate
        # So:
expr 7370348 * 0.9728  
        # Result = 7169874.534
expr (7169874.534 * 75) / 2226747 
        # Result = 241.49 X
