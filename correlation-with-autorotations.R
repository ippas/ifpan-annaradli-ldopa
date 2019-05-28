#attempt to correlate behavior after apomorphine (autorotations) with gene expression

require(magrittr)

auto.rotations <- data.frame("rat" = c("L1star","L2star","L4star","L5star","L6star"), "sample" = c("q16_0", "q17_0", "q18_0", "q19_0", "q20_0"), "total.rotations" = c(121.5, 240, 204.5, 267.75, 227))


correlation <- function(y) {
  x <- as.numeric(t(auto.rotations)[3,])
  cor.test(x, y, method="pearson") %>% unlist %>% extract("p.value")
}

results.corr <- apply(fpkms.log[,6:10], 1, correlation)

results.corr <- data.frame(results.log$geneID, results.log$gene.name, results.corr, results.log$mean.fpkm)
colnames(results.corr) <- c("geneID", "gene.name", "p.Corr", "mean.fpkm.log")

corr.adjust <- function(data, mean, threshold = 1) {
  filtered <- subset(data, data$mean.fpkm.log > mean)
  fdr.Corr <- p.adjust(filtered$p.Corr, method = "fdr")
  cut.res <- cbind(filtered, fdr.Corr)
  cut.res[
    which(cut.res$fdr.Corr < threshold),
    ]
}

corr.adjust(results.corr, 1, 1)
#this gave zero output as all FDRs were = 1

#i have also tried to check the selected genes

results.corr <- apply(fpkms.log[match(rownames(selected.genes.log), rownames(fpkms.log)),16:20], 1, correlation)
results.corr <- data.frame(results.corr)
results.corr$fdr.corr <- p.adjust(results.corr[,1], method="fdr")

#this gave zero output as all FDRs were = 1, thus no significant correlations were found



