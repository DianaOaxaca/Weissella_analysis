#/usr/local/bin/R
#Rafael Lopez Sanchez

#1.Upload the R packages phyloseq, metagenomeSeq, vegan and MASS
library("phyloseq")
library("metagenomeSeq")
library("vegan")
library("MASS")
#2.Making the matrix from the filtered_otu_table.txt file
otu_df<-read.table("filtered_otu_table.txt", header=TRUE, row.names=1, sep="\t")
otu_mat<-as.matrix(otu_df)
#3.Making the transposed matrix.
transp_otu_mat<-t(otu_mat)
#4.Choosing the colors for variables.
mi_color=c(“yellow”, "deepskyblue", "deeppink", “green”, “red”,”orange”)
S <- specnumber(transp_otu_mat)
raremax <- min(rowSums(transp_otu_mat))
otu<-rarecurve(transp_otu_mat, step = 200, sample = raremax, col=mi_color, cex = 0.6)
Nmax <- sapply(out, function(x) max(attr(x, "Subsample")))
Smax <- sapply(out, max)
png("rarefaction_locator.png", width = 7*300, height = 5*300, res = 400, pointsize = 8)

plot(c(1, max(Nmax)), c(1, max(Smax)), xlab = "Sample Size", ylab = "Species", type = "n", cex.lab=0.8, cex.axis=0.8)

#abline(v = raremax)

for (i in seq_along(out)) {
N <- attr(out[[i]], "Subsample")lines(N, out[[i]], col = mi_color[i])text(locator(1), labels=row.names(transp_otu_mat)[i], cex=0.8)
}

dev.off()
