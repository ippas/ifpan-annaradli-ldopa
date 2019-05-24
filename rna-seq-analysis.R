#read fpkm values
fpkms.only <- read.delim("http://149.156.177.112/projects/ifpan-annaradli-ldopa/data/cuffnorm/genes.count_table", header = TRUE, sep="")
rownames(fpkms.only) <- fpkms.only[,1]
fpkms.only <- fpkms.only[,-1]

#create table with sample information
Animal <- factor(c(1:10,1:10))
Hemisphere <- factor(c(rep("L", 10), rep("R", 10)))
Treatment <- factor(c(rep("OHDHA", 5), rep("LDOPA", 5), rep("OHDHA", 5), rep("LDOPA", 5)))
Sample.info <- data.frame(Samples=colnames(counts.only),Animal,Hemisphere,Treatment)

#normalize the distribution
fpkms.normalised <- data.matrix(fpkms.only)
normalize.quantiles(fpkms.normalised,copy=FALSE)
fpkms.log <- log2(fpkms.normalised + 1)

#attach gene names and IDs
rnor.gene.list <- read.delim("~/ifpan-annaradli-ldopa-R-analysis/mart_export_rnor.txt")
results.log <- data.frame(results.log)
results.log$gene.name = rnor.gene.list$Gene.name[match(rownames(results), rnor.gene.list$Gene.stable.ID)]
results.log$geneID <- rownames(results.log)


#analyze gene expression
require(magrittr)
stat <- function(x) {
  summary(aov(x ~ Hemisphere * Treatment + Error(Animal/Hemisphere))) %>% 
    unlist %>% 
    extract(c("Error: Animal.Pr(>F)1","Error: Animal:Hemisphere.Pr(>F)1","Error: Animal:Hemisphere.Pr(>F)2"))
  
}

results.log <- apply(fpkms.log, 1, stat) %>% t
colnames(results.log) <- c("p.Hemisphere", "p.Treatment", "p.Interaction")

results.adjusted <- p.adjust(results.log[,1], method="fdr")
results.log <- cbind(results.log, results.adjusted)
colnames(results.log)[colnames(results.log) == "results.adjusted"] <- "Treatment:FDR"

results.adjusted <- p.adjust(results.log[,2], method="fdr")
results.log <- cbind(results.log, results.adjusted)
colnames(results.log)[colnames(results.log) == "results.adjusted"] <- "Hemisphere:FDR"

results.adjusted <- p.adjust(results.log[,3], method="fdr")
results.log <- cbind(results.log, results.adjusted)
colnames(results.log)[colnames(results.log) == "results.adjusted"] <- "Interaction:FDR"
rm(results.adjusted)

#filter per count and recalculate FDR
results.log$mean.fpkm <- rowMeans(fpkms.log)

cut.adjust <- function(data, mean, threshold) {
  filtered <- subset(data, data$mean.fpkm > mean)
  fdr.Hem <- p.adjust(filtered$p.Hemisphere, method = "fdr")
  fdr.Tr <- p.adjust(filtered$p.Treatment, method = "fdr")
  fdr.Int <- p.adjust(filtered$p.Interaction, method = "fdr")
  cut.res <- cbind(filtered, fdr.Hem, fdr.Tr, fdr.Int)
  cut.res[
    which(cut.res$fdr.Hem < threshold |
            cut.res$fdr.Tr < threshold |
            cut.res$fdr.Int < threshold),
    ]
}

#chosing top genes with any FDR <0.05
selected.genes.log <- cut.adjust(results.log, 1, threshold = 0.05)

#calculating FDR for all genes
temp.res.log <- cut.adjust(results.log, 1, threshold = 1)

all.genes.log <- data.frame(results.log$geneID, results.log$gene.name, results.log$mean.fpkm)

all.genes.log$fdr.hemisphere <- temp.res.log$fdr.Hem[match(all.genes.log$geneID, temp.res.log$geneID)]
all.genes.log$fdr.treatment <- temp.res.log$fdr.Tr[match(all.genes.log$geneID, temp.res.log$geneID)]
all.genes.log$fdr.interaction <- temp.res.log$fdr.Int[match(all.genes.log$geneID, temp.res.log$geneID)]
rm(temp.res.log)

#saving a table with all genes and their FDRs:
write.csv(all.genes.log, "all-genes.csv", row.names = FALSE)


#calculating fold changes of top genes
fold.change.log <- data.frame(
  rowMeans(fpkms.log[,c("q1_0", "q2_0", "q3_0", "q4_0", "q5_0")]), 
  rowMeans(fpkms.log[,c("q6_0", "q7_0", "q8_0", "q9_0", "q10_0")]),
  rowMeans(fpkms.log[,c("q11_0", "q12_0", "q13_0", "q14_0", "q15_0")]),
  rowMeans(fpkms.log[,c("q16_0", "q17_0",  "q18_0", "q19_0", "q20_0")])
)

colnames(fold.change.log) <- c("mean.L.OHDHA", "mean.L.LDOPA", "mean.R.OHDHA", "mean.R.LDOPA")

fold.change.log$fold.lefts <- fold.change.log$mean.L.LDOPA - fold.change.log$mean.L.OHDHA
fold.change.log$fold.rights <- fold.change.log$mean.R.LDOPA - fold.change.log$mean.R.OHDHA
fold.change.log$fold.within.OHDHA <- fold.change.log$mean.L.OHDHA - fold.change.log$mean.R.OHDHA
fold.change.log$fold.within.LDOPA <- fold.change.log$mean.L.LDOPA - fold.change.log$mean.R.LDOPA
fold.change.log$fold.treatment <- (fold.change.log$mean.R.LDOPA + fold.change.log$mean.L.LDOPA) - (fold.change.log$mean.R.OHDHA + fold.change.log$mean.L.OHDHA)
fold.change.log$fold.hemisphere <- (fold.change.log$mean.R.LDOPA + fold.change.log$mean.R.OHDHA) - (fold.change.log$mean.L.LDOPA + fold.change.log$mean.L.OHDHA)

selected.genes.log$fold.lefts <- fold.change.log$fold.lefts[match(rownames(selected.genes.log), rownames(fold.change.log))]
selected.genes.log$fold.rights <- fold.change.log$fold.rights[match(rownames(selected.genes.log), rownames(fold.change.log))]
selected.genes.log$fold.within.OHDHA <- fold.change.log$fold.within.OHDHA[match(rownames(selected.genes.log), rownames(fold.change.log))]
selected.genes.log$fold.within.LDOPA <- fold.change.log$fold.within.LDOPA[match(rownames(selected.genes.log), rownames(fold.change.log))]
selected.genes.log$fold.treatment <- fold.change.log$fold.treatment[match(rownames(selected.genes.log), rownames(fold.change.log))]
selected.genes.log$fold.hemisphere <- fold.change.log$fold.hemisphere[match(rownames(selected.genes.log), rownames(fold.change.log))]

selected.genes.log$fold.lefts <- abs(selected.genes.log$fold.lefts)
selected.genes.log$fold.rights <- abs(selected.genes.log$fold.rights)
selected.genes.log$fold.within.OHDHA <- abs(selected.genes.log$fold.within.OHDHA)
selected.genes.log$fold.within.LDOPA <- abs(selected.genes.log$fold.within.LDOPA)
selected.genes.log$fold.treatment <- abs(selected.genes.log$fold.treatment)
selected.genes.log$fold.hemisphere <- abs(selected.genes.log$fold.hemisphere)

#saving a table with top genes and their folds
write.csv(selected.genes.log, "selected-genes-log.csv", row.names = FALSE)

#plotting heatmaps (heatmap was adjusted manually)
require(gplots)
require(RColorBrewer)
mypalette <- brewer.pal(11,"RdBu")
morecols <- colorRampPalette(mypalette)

y <- fpkms.log[match(rownames(selected.genes.log),rownames(fpkms.log)),]
hr <- hclust(as.dist(1-cor(t(y), method="pearson")), method="complete")

heatmap.2(y,
          Rowv = as.dendrogram(hr),
          Colv = FALSE,
          col=rev(morecols(50)),trace="none", 
          main="",
          scale="row",
          colsep = c(5,10,15),
          labRow=selected.genes.log$gene.name,
          labCol=c("","","","ipsi-OHDHA","","","","","ipsi-LDOPA","","","","","contra-OHDHA","","","","","contra-LDOPA",""),         
          srtCol = 0
)


