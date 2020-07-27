#/usr/local/bin/R
#Rafael Lopez Sanchez

### NMDS with Bray-Curtis dissimilitary index
#1. Upload Mass and Vegan packages from R
library("MASS")
library("vegan")

#2.otu_df<-read.table("normal_otu_table.txt", header=TRUE, row.names=1, sep="\t")
otu_mat<-as.matrix(otu_df)
transp_otu_mat<-t(otu_mat)
cru.mds_meta <- metaMDS(transp_otu_mat, trace = FALSE, k=2, trymax=100)
var_stress<-round(cru.mds_meta$stress, 6)

#Assign color pallette.
my_color=c(rep("#FF00FF", 4), rep("#04CA4C", 4), rep("#2177CC", 4))
png("metamds_bray.png", width = 5*300, height = 5*300, res = 400, pointsize = 8)
plot(cru.mds_meta, type = "n")
text(cru.mds_meta, labels = row.names(transp_otu_mat), cex=0.7, col=my_color)
coord<-par("usr")
#text(coord[1]+0.058, coord[3]+0.015, labels=paste("Stress: ", var_stress, sep=''), cex=0.65)
text(coord[1]+0.3, coord[3]+0.1, labels=paste("Stress: ", var_stress, sep=''), cex=0.65)
legend(coord[2]-0.52, coord[4]-0.025, legend=c("0h", "SOGOM2", "SOGOM3"), fill=c("#FF00FF", "#04CA4C", "#2177CC"), border="white", bty="n", cex=0.7)
dev.off()
quit()
