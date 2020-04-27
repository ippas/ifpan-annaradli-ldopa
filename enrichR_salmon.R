library(enrichR)
library(dplyr)

salmonGenesHuman <- read.csv("salmonModule_biomaRt_rat2human.csv") #load file with human homologs of genes included in the "salmon" WGCNA module
salmonGenesHuman <- select(salmonGenesHuman, c("hgnc_symbol"))
removeHomologs <- c("ZNF189", "SIK1", "SIK1B", "NAT8", "NAT8B",  "C12orf43", "ZNF521", "RCOR2", "RSKR", "EWSR1", "RMDN3" ) #remove genes that have more than 1 human homolog or a different symbol than rat
salmonGenesHumanFiltered <- salmonGenesHuman$hgnc_symbol[! salmonGenesHuman$hgnc_symbol %in% removeHomologs]
salmonGenesHumanFiltered <- as.vector(salmonGenesHumanFiltered)

dbs <- listEnrichrDbs()
dbs <- c("GO_Molecular_Function_2018", "GO_Cellular_Component_2018", "GO_Biological_Process_2018",
         "TF_Perturbations_Followed_by_Expression", "RNA-Seq_Disease_Gene_and_Drug_Signatures_from_GEO", "DSigDB",
         "KEGG_2016", "MSigDB_Computational", "KEGG_2019_human", "KEGG_2019_mouse", "GWAS_Catalog_2019", 
         "DrugMatrix", "GeneSigDB", "Allen_Brain_Atlas_down", "Allen_Brain_Atlas_up", "TargetScan_microRNA_2017",
         "TRANSFAC_and_JASPAR_PWMs", "Drug_Perturbations_from_GEO_2014", "Drug_Perturbations_from_GEO_down", "Drug_Perturbations_from_GEO_up")
enrichedSalmonGenesHuman <- enrichr(salmonGenesHumanFiltered, dbs)
printEnrich(enrichedSalmonGenesHuman, "enrichR_salmonModule_humanHomologs_many_databases_21-01-2020.txt", sep = ";", columns = c(1:9) )

##################################################################################
GOMFadjustedSalmon <- filter(enrichedSalmonGenesHuman$GO_Molecular_Function_2018, Adjusted.P.value < 0.05) #8
GOCCadjustedSalmon <- filter(enrichedSalmonGenesHuman$GO_Cellular_Component_2018, Adjusted.P.value < 0.05) #0
GOBPadjustedSalmon <- filter(enrichedSalmonGenesHuman$GO_Biological_Process_2018, Adjusted.P.value < 0.05) #8
TFPFbEadjustedSalmon <- filter(enrichedSalmonGenesHuman$TF_Perturbations_Followed_by_Expression, Adjusted.P.value < 0.05) #238
RNASeqDisGEOadjustedSalmon <- filter(enrichedSalmonGenesHuman$`RNA-Seq_Disease_Gene_and_Drug_Signatures_from_GEO`, Adjusted.P.value < 0.05) #183
DSigDBadjustedSalmon <- filter(enrichedSalmonGenesHuman$DSigDB, Adjusted.P.value < 0.05) #394
KEGG2016adjustedSalmon <- filter(enrichedSalmonGenesHuman$KEGG_2016, Adjusted.P.value < 0.05) #0
MSigDBadjustedSalmon <- filter(enrichedSalmonGenesHuman$MSigDB_Computational, Adjusted.P.value < 0.05) #14
KEGG2019HumanadjustedSalmon <- filter(enrichedSalmonGenesHuman$KEGG_2019_human, Adjusted.P.value < 0.05) #0
KEGG2019MouseadjustedSalmon <- filter(enrichedSalmonGenesHuman$KEGG_2019_mouse, Adjusted.P.value < 0.05) #0
GWASadjustedSalmon <- filter(enrichedSalmonGenesHuman$GWAS_Catalog_2019, Adjusted.P.value < 0.05) #0
DrugMatrixadjustedSalmon <- filter(enrichedSalmonGenesHuman$DrugMatrix, Adjusted.P.value < 0.05) #360
GeneSigDBadjustedSalmon <- filter(enrichedSalmonGenesHuman$GeneSigDB, Adjusted.P.value < 0.05) #97
AllenDownadjustedSalmon <- filter(enrichedSalmonGenesHuman$Allen_Brain_Atlas_down, Adjusted.P.value < 0.05) #0
AllenUpadjustedSalmon <- filter(enrichedSalmonGenesHuman$Allen_Brain_Atlas_up, Adjusted.P.value < 0.05) #65
TargetScan2017adjustedSalmon <- filter(enrichedSalmonGenesHuman$TargetScan_microRNA_2017, Adjusted.P.value < 0.05) #11
TRANSFACadjustedSalmon <- filter(enrichedSalmonGenesHuman$TRANSFAC_and_JASPAR_PWMs, Adjusted.P.value < 0.05) #13
DrugPert2014adjustedSalmon <- filter(enrichedSalmonGenesHuman$Drug_Perturbations_from_GEO_2014, Adjusted.P.value < 0.05) #75
DrugPertDownadjustedSalmon <- filter(enrichedSalmonGenesHuman$Drug_Perturbations_from_GEO_down, Adjusted.P.value < 0.05) #151
DrugPertUpadjustedSalmon <- filter(enrichedSalmonGenesHuman$Drug_Perturbations_from_GEO_up, Adjusted.P.value < 0.05) #261



write.csv(TFPFbEadjustedSalmon, file = "enrichR_salmonModule_TFPFbEadjusted.csv")
write.csv(RNASeqDisGEOadjustedSalmon, file = "enrichR_salmonModule_RNASeqDisGEOadjusted.csv")
write.csv(DSigDBadjustedSalmon, file = "enrichR_salmonModule_DSigDBadjusted.csv")
write.csv(KEGG2016adjustedSalmon, file = "enrichR_salmonModule_KEGG2016adjusted.csv")
write.csv(GeneSigDBadjustedSalmon, file = "enrichR_salmonModule_GeneSigDBadjustedSalmon.csv")
write.csv(TRANSFACadjustedSalmon, file = "enrichR_salmonModule_TRANSFACadjusted.csv")
write.csv(DrugPert2014adjustedSalmon, file = "enrichR_salmonModule_DrugPert2014adjusted.csv")
write.csv(DrugPertDownadjustedSalmon, file = "enrichR_salmonModule_DrugPertDownAdjusted.csv")
write.csv(MSigDBadjustedSalmon, file = "enrichR_salmonModule_MSigDBadjusted.csv")
write.csv(DrugPertUpadjustedSalmon, file = "enrichR_salmonModule_DrugPertUpAdjusted.csv")
write.csv(GOBPadjustedSalmon, file = "enrichR_salmonModule_GOBPadjusted.csv")
write.csv(GOMFadjustedSalmon, file = "enrichR_salmonModule_GOMFadjusted.csv")
write.csv(DrugMatrixadjustedSalmon, file = "enrichR_salmonModule_DrugMatrixAdjusted.csv")
write.csv(AllenUpadjustedSalmon, file = "enrichR_salmonModule_AllenUpadjusted.csv")
write.csv(TargetScan2017adjustedSalmon, file = "enrichR_salmonModule_TargetScan2017adjusted.csv")


