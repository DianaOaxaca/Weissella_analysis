#/usr/local/bin/R
#Rafael Lopez Sanchez

#1.Upload library phyloseq from R
library("phyloseq")

#2. Read the OTU matrix
args <- commandArgs(TRUE)
file_in <- as.character(args[1])
otu_df<-read.table(file_in, header=TRUE, row.names=1)

#3. Format the OTU matrix.
otu_mat<-as.matrix(otu_df)
taxrank_mat <- as.matrix(paste0("OTU", 1:nrow(otu_mat)))
rownames(taxrank_mat) <- rownames(otu_mat)
colnames(taxrank_mat) <- ("TAX")
OTU<-otu_table(otu_mat, taxa_are_rows=TRUE)
TAX<-tax_table(taxrank_mat)
physeq = phyloseq(OTU, TAX)

#4. Estimate richness and calculate Chao 1, Shannon-Weaver and Simpson indexes.
diversity_index<-as.data.frame(round(estimate_richness(physeq, measures=c("Observed", "Chao1", "Shannon","Simpson")), 2))
diversity_index2<-data.frame(Sample=rownames(diversity_index))
diversity_index3<-cbind(diversity_index2, diversity_index)
colnames(diversity_index3)=c("Sample","Observed", "Chao1", "se.chao1","Shannon","Simpson")

#5. Write the index table.
write.table(diversity_index3, "alpha_diversity_index.txt", quote = FALSE, sep = "\t", row.names = FALSE, col.names=TRUE)
quit()
