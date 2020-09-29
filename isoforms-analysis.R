isoform.list <- read.csv("isoforms.csv")
fpkms.iso <- read.delim("/home/ifpan/projects/ifpan-annaradli-ldopa/data/cuffnorm/isoforms.fpkm_table", header = TRUE, sep="")
rownames(fpkms.iso) <- fpkms.iso[,1]
fpkms.iso <- fpkms.iso[,-1]

require(preprocessCore)

fpkms.iso <- data.matrix(fpkms.iso)
fpkms.iso <- normalize.quantiles(fpkms.iso,copy=FALSE)
fpkms.iso <- log2(fpkms.iso + 1)

fpkms.iso <- data.frame(rownames(fpkms.iso), fpkms.iso)

fpkms.iso$gene.name = isoform.list$Gene.name[match(rownames(fpkms.iso), isoform.list$Transcript.stable.ID)]
fpkms.iso$transcript.name = isoform.list$Transcript.name[match(rownames(fpkms.iso), isoform.list$Transcript.stable.ID)]

names(fpkms.iso)[1]<-"transcript.ID"

fpkms.iso <- data.frame(fpkms.iso$gene.name, fpkms.iso$transcript.name, fpkms.iso$transcript.ID, fpkms.iso[,2:21])


for (gene in selected.genes.log$gene.name) {
  one.gene <- fpkms.iso[which(fpkms.iso$fpkms.iso.gene.name == gene),]
  selected.genes.isoforms <- rbind(selected.genes.isoforms, one.gene)
}
rm(gene, gene.name, one.gene)

require(dplyr)
which(duplicated(selected.genes.isoforms$fpkms.iso.gene.name) == "TRUE")
#it does not work cause it only detects rows after the first isoform, so I am adding new rows manualy

selected.genes.isoforms.only <- selected.genes.isoforms[c(1,2,3,6,7,11,12,13,14,15,16,21,22,23,24,27,28,29,30,33,34,35,36,37,40,41,43,44,58,59),]
selected.genes.isoforms <- selected.genes.isoforms.only
rm(selected.genes.isoforms.only)

selected.genes.isoforms$mean.fpkm <- rowMeans(selected.genes.isoforms[,4:23])

require(magrittr)

results.isoforms <- apply(selected.genes.isoforms[,4:23], 1, stat) %>% t
selected.genes.isoforms <- data.frame(selected.genes.isoforms, results.isoforms)
rm(results.isoforms)

selected.genes.isoforms$fdr.hem <- p.adjust(selected.genes.isoforms$Pr..F.1, method="fdr")
selected.genes.isoforms$fdr.tr <- p.adjust(selected.genes.isoforms$Pr..F.2, method="fdr")
selected.genes.isoforms$fdr.int <- p.adjust(selected.genes.isoforms$Pr..F.3, method="fdr")


#fold analysis
isoforms.fold.changes <- data.frame(
  rowMeans(selected.genes.isoforms[,c("q1_0", "q2_0", "q3_0", "q4_0", "q5_0")]), 
  rowMeans(selected.genes.isoforms[,c("q6_0", "q7_0", "q8_0", "q9_0", "q10_0")]),
  rowMeans(selected.genes.isoforms[,c("q11_0", "q12_0", "q13_0", "q14_0", "q15_0")]),
  rowMeans(selected.genes.isoforms[,c("q16_0", "q17_0",  "q18_0", "q19_0", "q20_0")])
)

colnames(isoforms.fold.changes) <- c("mean.L.OHDHA", "mean.L.LDOPA", "mean.R.OHDHA", "mean.R.LDOPA")

isoforms.fold.changes$fold.lefts <- isoforms.fold.changes$mean.L.LDOPA - isoforms.fold.changes$mean.L.OHDHA
isoforms.fold.changes$fold.rights <- isoforms.fold.changes$mean.R.LDOPA - isoforms.fold.changes$mean.R.OHDHA
isoforms.fold.changes$fold.within.OHDHA <- isoforms.fold.changes$mean.L.OHDHA - isoforms.fold.changes$mean.R.OHDHA
isoforms.fold.changes$fold.within.LDOPA <- isoforms.fold.changes$mean.L.LDOPA - isoforms.fold.changes$mean.R.LDOPA
isoforms.fold.changes$fold.treatment <- (isoforms.fold.changes$mean.R.LDOPA + isoforms.fold.changes$mean.L.LDOPA) - (isoforms.fold.changes$mean.R.OHDHA + isoforms.fold.changes$mean.L.OHDHA)
isoforms.fold.changes$fold.hemisphere <- (isoforms.fold.changes$mean.R.LDOPA + isoforms.fold.changes$mean.R.OHDHA) - (isoforms.fold.changes$mean.L.LDOPA + isoforms.fold.changes$mean.L.OHDHA)

selected.genes.isoforms$fold.treatment <- isoforms.fold.changes$fold.treatment
selected.genes.isoforms$fold.hemisphere <- isoforms.fold.changes$fold.hemisphere


colnames(selected.genes.isoforms) <- c("gene.name","transcript.name","transcript.ID","q1_0","q2_0","q3_0","q4_0","q5_0","q6_0","q7_0","q8_0","q9_0","q10_0","q11_0","q12_0","q13_0","q14_0","q15_0","q16_0","q17_0","q18_0","q19_0","q20_0","mean.fpkm","p.hem","p.treatment","p.int","fdr.hem","fdr.treatment","fdr.int","fold.treatment","fold.hemisphere")
write.csv(selected.genes.isoforms, "selected-genes-isoforms.csv", row.names = FALSE)
