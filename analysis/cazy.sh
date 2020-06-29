#!/usr/bin/bash
#Hernández-Oaxaca, Diana
#Workflow to cazy analysis
#1. Download databases

wget   http://csbl.bmb.uga.edu/dbCAN/download/CAZyDB.07202017.fa
wget   http://csbl.bmb.uga.edu/dbCAN/download/FamInfo.txt
wget   http://csbl.bmb.uga.edu/dbCAN/download/dbCAN-fam-HMMs.txt
wget   http://csbl.bmb.uga.edu/dbCAN/download/hmmscan-parser.sh 

#2. Format db

hmmpress dbCAN-fam-HMMs.txt

#3. Search domains

hmmscan --domtblout [SAMPLE_NAME].out.dm --cpu 21 dbCAN-fam-HMMs.txt [SAMPLE_PROTEINS_FILE.faa] > [SAMPLE_NAME].out

#4. Parser ou with 1x10-5 evalue and 80% cov

hmmscan-parser.sh [SAMPLE_NAME].out.dm > [SAMPLE_NAME].out.dm.ps

#5. Filter data

cut -f1,3 [SAMPLE_NAME].out.dm.ps  | sort -n > [SAMPLE_NAME].txt
sed -i 's/\.hmm//' [SAMPLE_NAME].txt
cut -f1 [SAMPLE_NAME].txt > [SAMPLE_NAME].only.txt
uniq -c [SAMPLE_NAME].only.txt > [SAMPLE_NAME].count

cat *.only.txt > all.only.txt 
sort all.only.txt |  uniq -c  > all.uniq.count
sort all.only.txt |  uniq   > all.uniq 

for s in $(cat all.uniq); do grep -c -w $s [SAMPLE_NAME].only.txt >> [SAMPLE_NAME].full_count ; done

#6. R Heatmap

library("ggplot2", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")
library("Heatplus", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")
library("gplots", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")
library("RColorBrewer", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")
setwd('/Users/REAnAr/Desktop/CAZy_SRvsLR/')
cazymes <- read.csv('all.uniq_all.count.csv', header = TRUE, row.names = 1)
my_pallet <- colorRampPalette(c('white', 'blue'))(n = 299)
col_breaks = c(seq(-0,1.09, length=100), seq(1.1,2.09,length=100), seq(2.1,4,length=100))
heatmap.2(as.matrix(cazymes), col = my_pallet, density.info = 'none', trace = 'none', dendrogram = 'none', Rowv = "NA", cexCol = 0.7, cexRow = 0.7, \
margins = c(2,16), breaks = col_breaks, tracecol = "row", offsetRow=-0.3, offsetCol=-0.3, key = FALSE)
