

#Phylum

#1.Read Table
phy_table<-read.table("phylum.txt", header=TRUE, row.names=1)

#2. Assign color palette.
color = grDevices::colors()[grep('gr(a|e)y', grDevices::colors(), invert = T)]
my_color=c(sample(color, 23))

#3.Create png.
png("phylum.png", width = 5300, height = 5300, res = 300, pointsize = 10)
par(mar=c(6,8,4,32))

#4.Make sockplot.
barplot(as.matrix(phy_table), col=my_color, cex.axis=2.8, cex.lab=2.8, cex.names=2.8, las=2.8, legend.text=TRUE, args.legend = list(x=ncol(phy_table)+3.3, y=max(colSums(phy_table)), cex=2.5))
dev.off()

#Genus sockplot

#1.Read Table
gen_table<-read.table("genus.txt", header=TRUE, row.names=1)

#2. Assign color palette.
color = grDevices::colors()[grep('gr(a|e)y', grDevices::colors(), invert = T)]
my_color=c(sample(color, 100))

#3.Create png.
png("genus.png", width = 5300, height = 5300, res = 300, pointsize = 10)
par(mar=c(6,8,4,32))

#4.Make sockplot.
barplot(as.matrix(gen_table), col=my_color, cex.axis=2.8, cex.lab=2.8, cex.names=2.8, las=2.8, legend.text=TRUE, args.legend = list(x=ncol(gen_table)+3.3, y=max(colSums(gen_table)), cex=2.5))
dev.off()
