library(enrichR)
library(dplyr)

topGenesHuman <- read.csv("top48genes_biomaRt_rat2human.csv")  #load file with human homologs of the differentially expressed genes
topGenesHuman <- select(topGenesHuman, c("hgnc_symbol"))
topGenesHuman <- topGenesHuman[!grepl("ZNF189", topGenesHuman$hgnc_symbol),] #remove gene that has a different human homolog name than the rat one
topGenesHuman <- as.vector(topGenesHuman)

dbs <- listEnrichrDbs()
dbs <- c("GO_Molecular_Function_2018", "GO_Cellular_Component_2018", "GO_Biological_Process_2018",
         "TF_Perturbations_Followed_by_Expression", "RNA-Seq_Disease_Gene_and_Drug_Signatures_from_GEO", "DSigDB",
         "KEGG_2016", "MSigDB_Computational", "KEGG_2019_human", "KEGG_2019_mouse", "GWAS_Catalog_2019", 
         "DrugMatrix", "GeneSigDB", "Allen_Brain_Atlas_down", "Allen_Brain_Atlas_up", "TargetScan_microRNA_2017",
         "TRANSFAC_and_JASPAR_PWMs", "Drug_Perturbations_from_GEO_2014", "Drug_Perturbations_from_GEO_down", "Drug_Perturbations_from_GEO_up")
enrichedTopGenesHuman <- enrichr(topGenesHuman, dbs)

##################################################################################
GOMFadjusted <- filter(enrichedTopGenesHuman$GO_Molecular_Function_2018, Adjusted.P.value < 0.05) #0
GOCCadjusted <- filter(enrichedTopGenesHuman$GO_Cellular_Component_2018, Adjusted.P.value < 0.05) #0
GOBPadjusted <- filter(enrichedTopGenesHuman$GO_Biological_Process_2018, Adjusted.P.value < 0.05) #0
TFPFbEadjusted <- filter(enrichedTopGenesHuman$TF_Perturbations_Followed_by_Expression, Adjusted.P.value < 0.05) #108
RNASeqDisGEOadjusted <- filter(enrichedTopGenesHuman$`RNA-Seq_Disease_Gene_and_Drug_Signatures_from_GEO`, Adjusted.P.value < 0.05) #63
DSigDBadjusted <- filter(enrichedTopGenesHuman$DSigDB, Adjusted.P.value < 0.05) #108
KEGG2016adjusted <- filter(enrichedTopGenesHuman$KEGG_2016, Adjusted.P.value < 0.05) #1
MSigDBadjusted <- filter(enrichedTopGenesHuman$MSigDB_Computational, Adjusted.P.value < 0.05) #3
KEGG2019HumanAdjusted <- filter(enrichedTopGenesHuman$KEGG_2019_human, Adjusted.P.value < 0.05) #0
KEGG2019MouseAdjusted <- filter(enrichedTopGenesHuman$KEGG_2019_mouse, Adjusted.P.value < 0.05) #0
GWASadjusted <- filter(enrichedTopGenesHuman$GWAS_Catalog_2019, Adjusted.P.value < 0.05) #0
DrugMatrixAdjusted <- filter(enrichedTopGenesHuman$DrugMatrix, Adjusted.P.value < 0.05) #0
GeneSigDBadjusted <- filter(enrichedTopGenesHuman$GeneSigDB, Adjusted.P.value < 0.05) #6
AllenDownAdjusted <- filter(enrichedTopGenesHuman$Allen_Brain_Atlas_down, Adjusted.P.value < 0.05) #0
AllenUpAdjusted <- filter(enrichedTopGenesHuman$Allen_Brain_Atlas_up, Adjusted.P.value < 0.05) #0
TargetScan2017Adjusted <- filter(enrichedTopGenesHuman$TargetScan_microRNA_2017, Adjusted.P.value < 0.05) #0
TRANSFACadjusted <- filter(enrichedTopGenesHuman$TRANSFAC_and_JASPAR_PWMs, Adjusted.P.value < 0.05) #1
DrugPert2014adjusted <- filter(enrichedTopGenesHuman$Drug_Perturbations_from_GEO_2014, Adjusted.P.value < 0.05) #31
DrugPertDownAdjusted <- filter(enrichedTopGenesHuman$Drug_Perturbations_from_GEO_down, Adjusted.P.value < 0.05) #49
DrugPertUpAdjusted <- filter(enrichedTopGenesHuman$Drug_Perturbations_from_GEO_up, Adjusted.P.value < 0.05) #162


write.csv(TFPFbEadjusted, file = "enrichR_46topgenesHuman_TFPFbEadjusted.csv")
write.csv(RNASeqDisGEOadjusted, file = "enrichR_46topgenesHuman_RNASeqDisGEOadjusted.csv")
write.csv(DSigDBadjusted, file = "enrichR_46topgenesHuman_DSigDBadjusted.csv")
write.csv(KEGG2016adjusted, file = "enrichR_46topgenesHuman_KEGG2016adjusted.csv")
write.csv(GeneSigDBadjusted, file = "enrichR_46topgenesHuman_GeneSigDBadjusted.csv")
write.csv(TRANSFACadjusted, file = "enrichR_46topgenesHuman_TRANSFACadjusted.csv")
write.csv(DrugPert2014adjusted, file = "enrichR_46topgenesHuman_DrugPert2014adjusted.csv")
write.csv(DrugPertDownAdjusted, file = "enrichR_46topgenesHuman_DrugPertDownAdjusted.csv")
write.csv(MSigDBadjusted, file = "enrichR_46topgenesHuman_MSigDBadjusted.csv")
write.csv(DrugPertUpAdjusted, file = "enrichR_46topgenesHuman_DrugPertUpAdjusted.csv")
