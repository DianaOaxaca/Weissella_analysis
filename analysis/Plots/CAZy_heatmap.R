#/usr/local/bin/R
#DianaOaxaca

##Heatmap
#1. Read matrix
cazymes <- read.csv("cazy_per_substrate2.csv", header = TRUE, row.names = 1)
#2. Read categories
sustrato <-read.csv("sustrato.csv", header = TRUE)
#3. Define color palette
my_pallet <- colorRampPalette(c('black', 'red'))(n = 299)
#4. Define data characteristics
col_breaks = c(seq(-0,1.09, length=100), seq(1.1,2.09,length=100), seq(2.1,8,length=100))
#5. Draw heatmap
heatmap.2(as.matrix(cazymes), col = my_pallet, main = "CAZymes", density.info = 'none', 
          trace = 'none', dendrogram = 'col', Rowv = "NA", cexCol = 0.62, cexRow = 0.6, 
          margins = c(7,6), tracecol = "both", breaks = col_breaks, offsetRow=-0.3,
          offsetCol=-0.3, key.title=TRUE, key.xlab="Number of CAZy families")
