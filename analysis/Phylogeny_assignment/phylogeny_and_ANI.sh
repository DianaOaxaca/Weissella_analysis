#!/usr/bin/bash
#DianaOaxaca
#Workflow to build phylogenies and ANI analysis by Luis F. Lozano Aguirre B.

#1.Housekeeping (HK)
#1.1 Align HK fasta

muscle -in ddl.fasta -out ddl.fasta.mus
muscle -in g6pd.fasta -out g6pd.fasta.mus
muscle -in pgm.fasta -out pgm.fasta.mus
muscle -in pheS.fasta -out pheS.fasta.mus
muscle -in rpoA.fasta -out rpoA.fasta.mus

#1.2 Concatenate alignments (conca.l = local script)

perl conca.l > Weissella_HKalin.fasta

#1.3 predict model

jmodeltest -d Weissella_HKalin.fasta -s 11 -i -f -g 4 -BIC -AIC -AICc -DT -v -a -w 

#Build phylogeny

raxmlHPC -f a -m PROTGAMMAIWAGF -p 12345 -x 12345 -# 100 -s Weissella_HKalin.fasta -n WEISHK

#2.Housekeeping (HK)
#2.1 Obtain ribo proteins (RP)

	#Local script

#2.2 Align RP fasta (All.fasta) example:

muscle -in RP_L1.fasta -out RP_L10.fasta.mus

perl conca.l > Weissella_RPalin_18.fasta

#1.3 predict model

jmodeltest -d Weissella_HKalin_18.fasta -s 11 -i -f -g 4 -BIC -AIC -AICc -DT -v -a -w 

#2.5 Build phylogeny

raxmlHPC -f a -m PROTGAMMAILGF -p 12345 -x 12345 -# 100 -s Weissella_RPalin_18.fasta -n WEIS18 


#3.ANI

average_nucleotide_identity.py -i genomes/ -m ANIm -g --labels labels.tab -o ANIm_output
