#"WGCNA" package is dependent on the following packages:
#"matrixStats", "Hmisc", "splines", "foreach", "doParallel", "fastcluster", "dynamicTreeCut", "survival"
#from Bioconductor: "GO.db", "preprocessCore", "impute"
library("WGCNA")

#1. Loading files, formating data to process, checking the correlation between FPKM counts and no. of rotations
options(stringsAsFactors = FALSE)
fpkmData = read.csv("fpkm_above1_all_samples.csv") #loads the file with log2(FPKM+1) counts for the 12,455 genes 
dim(fpkmData); #returns number of rows (without header) and number of columns
names(fpkmData); #shows column names

#creates table - transposition and removal of unnecessary data
#leaves sample numbers as rows, geneIDs as columns
fpkmDataExpr0 = as.data.frame(t(fpkmData[, -c(1:6, 27)]));
names(fpkmDataExpr0) = fpkmData$geneID;
rownames(fpkmDataExpr0) = names(fpkmData)[-c(1:6, 27)];

#checks genes and samples for excessive number of missing values
gsg = goodSamplesGenes(fpkmDataExpr0, verbose = 3);
gsg$allOK #returns TRUE if all the genes passed the test

#sample clustering and checking for outliers
fpkmSampleTree = hclust(dist(fpkmDataExpr0), method = "average");
sizeGrWindow(12,12)
par(cex = 0.6)
par(mar = c(0,4,2,0))
plot(fpkmSampleTree, main = "Sample clustering to detect outliers in our data",
     sub="", xlab="", cex.lab = 1.5, cex.axis = 1.5, cex.main = 2)


#draws a line on a given height
abline(h=80, col = "red")
#cuts out an outlier 
cluster = cutreeStatic(fpkmSampleTree, cutHeight = 80, minSize = 10)
table(cluster) # no sample was excluded from the analysis
#cluster 1 contains samples to be included in the analysis (all samples)
fpkmKeepSamples = (cluster==1)
fpkmDataExpr = fpkmDataExpr0[fpkmKeepSamples, ]
fpkmNGenes = ncol(fpkmDataExpr)
fpkmNSamples = nrow(fpkmDataExpr)
#fpkmDataExpr contains data ready for network analysis

#analysis of correlation between gene expression data and traits data (no. of rotations)
traitData = read.csv(file = "sample_data.csv", sep = ";"); #loads file with no. of rotations
dim(traitData)
names(traitData)
allTraits = traitData[, -c(2:4, 7:9)];
#allTraits = allTraits [, c(1, 2:6)];
dim(allTraits)
names(allTraits)

fpkmSamples = rownames(fpkmDataExpr);
traitRows = match(fpkmSamples, allTraits$X);
datTraits = allTraits[traitRows, -1];
rownames(datTraits) = allTraits[traitRows, 1];
collectGarbage();

fpkmSampleTree2 = hclust(dist(fpkmDataExpr), method = "average")
traitColors = numbers2colors(datTraits, signed = FALSE);
plotDendroAndColors(fpkmSampleTree2, traitColors, groupLabels = names(datTraits),
                    main = "Sample dendrogram and trait heatmap (all samples)") #plots correlation between FPKM counts and no. of rotations


save(fpkmDataExpr, file = "fpkm-wgcna-01-traits-allsamples-dataInput.RData") #version with all samples and the rotations data
#fpkmNames contains variable names from "fpkm-wgcna-01-dataInput.RData"
fpkmNames = load(file = "fpkm-wgcna-01-traits-allsamples-dataInput.RData")

###########################################################################
#2. Creating network

#choosing soft-thresholding power
fpkmPowers = c(c(1:10), seq(from = 11, to=31, by=2)) 
fpkmSft = pickSoftThreshold(fpkmDataExpr, powerVector = fpkmPowers, verbose = 5)
#power=11 chosen as the beta (power) in accordance with the table (R^2 > 0.8 for power = 11)

#plots "Scale-free topology fit index" as a function of soft-thresholding power
sizeGrWindow(9, 5)
par(mfrow = c(1,2));
cex1 = 0.9;
plot(fpkmSft$fitIndices[,1], -sign(fpkmSft$fitIndices[,3])*fpkmSft$fitIndices[,2],
                                   xlab="Soft Threshold (power)", ylab="Scale-free Topology ModelFit, signed R^2",
                                   type="n", main = paste("Scale independence"));
                              xlim = c(-1, 10)
text(fpkmSft$fitIndices[,1], -sign(fpkmSft$fitIndices[,3])*fpkmSft$fitIndices[,2],
     labels = fpkmPowers, cex = cex1, col = "red");
abline(h=0.8, col = "purple")
#plots "Mean connectivity"
plot(fpkmSft$fitIndices[,1], fpkmSft$fitIndices[,5], xlab="Soft Threshold (power)",
     ylab="Mean Connectivity", type="n", main = paste("Mean connectivity"), ylim = c(0, 500))
text(fpkmSft$fitIndices[,1], fpkmSft$fitIndices[,5], labels = fpkmPowers, cex = cex1, col = "green")


#module construction - the "step-by-step" approach
#calculation of adjacencies
softPower = 11;
adjacency = adjacency(fpkmDataExpr, power = softPower);

#transformation of the adjacency into Topological Overlap Matrix (TOM) and dissimilarity (dissTOM)
#this eliminates effects of noise and spurious associations
TOM = TOMsimilarity(adjacency, TOMType = "signed");
dissTOM = 1-TOM

#clustering using TOM
geneTree = hclust(as.dist(dissTOM), method = "average");
# sizeGrWindow(12, 9)
plot(geneTree, xlab = "", sub = "", main = "Gene clustering on TOM-based dissimilarity",
     labels = FALSE, hang = 0.04);
minModuleSize = 30;
dynamicMods = cutreeDynamic(dendro = geneTree, distM = dissTOM,
                            method = "hybrid",
                            maxCoreScatter = 1.5,
                            minGap = 0.05,
                            pamRespectsDendro = FALSE,
                            minClusterSize = minModuleSize);
table(dynamicMods) #shows modules as numbers with no. of assigned genes

#labeling modules with colors
dynamicColors = labels2colors(dynamicMods)
table(dynamicColors) #shows modules as labeled colors with no. of assigned genes

sizeGrWindow(8, 6)
plotDendroAndColors(geneTree, dynamicColors, "Dynamic Tree Cut",
                    dendroLabels = FALSE, hang = 0.03,
                    addGuide = TRUE, guideHang = 0.05,
                    main = "Gene dendrogram and module colors")
#quantification of co-expression similarity of entire modules (eigengenes and their clustering based on their correlation)
MEList = moduleEigengenes(fpkmDataExpr, colors = dynamicColors)
MEs = MEList$eigengenes
MEDiss = 1-cor(MEs);
METree = hclust(as.dist(MEDiss), method = "average");
sizeGrWindow(7, 6)
plot(METree, main = "Clustering of module eigengenes- stepbystep",
     xlab = "", sub = "")
MEDissThres = 0.5
abline(h = MEDissThres, col = "purple")
merge = mergeCloseModules(fpkmDataExpr, dynamicColors, cutHeight = MEDissThres, verbose = 3) #merging modules from "cutreeDynamic" 
mergedColors = merge$colors;
mergedMEs = merge$newMEs;

#adds new part to the plot with newly merged modules
sizeGrWindow(12, 9)
plotDendroAndColors(geneTree, cbind(dynamicColors, mergedColors),
                    c("Dynamic Tree Cut", "Merge dynamic"),
                    dendroLabels = FALSE, hang = 0.03,
                    addGuide = TRUE, guideHang = 0.05)
table(mergedColors)

#Rename to moduleColors
moduleColors = mergedColors
colorOrder = c("grey", standardColors(50));
moduleLabels = match(moduleColors, colorOrder)-1;
MEs = mergedMEs;
table(MEs)
save(MEs, moduleLabels, moduleColors, geneTree, file = "step-by-step-analysis.RData")

