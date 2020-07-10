#!/usr/bin/bash
#DianaOaxaca
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

#6. Local script to build the  counts matrix
