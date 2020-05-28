library("biomaRt")
library(dplyr)

#load the files
topGenes <- read.csv("selected-genes-log.csv", sep = ";") #differentially expressed genes
topGenes <- select(topGenes, c("geneID", "gene.name"))

salmonSymbols <- read.csv("Salmon-symbols.csv") #genes included in the "salmon" WGCNA module as Ensembl IDs with corresponding gene symbols

###########################################################################################
# DIFFERENTIALLY EXPRESSED GENES
# RAT => MOUSE

#rat Ensembl IDs to mouse Ensembl IDs
 martR <- useMart("ensembl", dataset="rnorvegicus_gene_ensembl")
 rat2mouseEnsembl <- getBM(attributes=c("ensembl_gene_id","mmusculus_homolog_ensembl_gene"),
                 mart=martR)
 
#mouse Ensembl IDs to mouse (MGI) gene symbols
martM <- useMart("ensembl", dataset = "mmusculus_gene_ensembl")
mouseEns2mouseSymbol <- getBM(attributes = c("ensembl_gene_id", "mgi_symbol"), mart = martM)
 
#merge lists and rename column
topGenesRat2MouseEns <- merge(topGenes, rat2mouseEnsembl, by.x="geneID", by.y="ensembl_gene_id",
                    sort=FALSE)
topGenesRat2MouseSymbol <- merge(topGenesRat2MouseEns, mouseEns2mouseSymbol, by.x = "mmusculus_homolog_ensembl_gene", by.y = "ensembl_gene_id",
                                 sort = FALSE)
topGenesRat2MouseSymbol <- rename(topGenesRat2MouseSymbol, rat_gene_symbol = gene.name)

topGenesRat2MouseSymbol <- rename(topGenesRat2MouseSymbol, rat_ensembl_gene = geneID)
  
#export list of mouse homologs
write.csv(topGenesRat2MouseSymbol, file = "top48genes_biomaRt_rat2mouse.csv")

#find different gene names between the rat and mouse homologs
rat2mouseDiff <- topGenesRat2MouseSymbol$rat_gene_symbol[!(topGenesRat2MouseSymbol$rat_gene_symbol %in% topGenesRat2MouseSymbol$mgi_symbol)]
#returns Il6r
rat2mouseDiffRev <- topGenesRat2MouseSymbol$mgi_symbol[!(topGenesRat2MouseSymbol$mgi_symbol %in% topGenesRat2MouseSymbol$rat_gene_symbol)]
#returns Il6ra



#check if any gene has more or less than 1 homolog
n.occurtopGenesRat2mouse <- data.frame(table(topGenesRat2MouseSymbol$rat_ensembl_gene))
n.occurtopGenesRat2mouse[n.occurtopGenesRat2mouse$Freq != 1,]
#                 Var1 Freq
#12 ENSRNOG00000007390    0 - Nfkbia

###########################################################################################
# RAT => HUMAN

#rat Ensembl IDs to human Ensembl IDs
martR <- useMart("ensembl", dataset="rnorvegicus_gene_ensembl")
rat2humanEnsembl <- getBM(attributes=c("ensembl_gene_id","hsapiens_homolog_ensembl_gene"),
                          mart=martR)

#human Ensembl IDs to human (HGNC) gene symbols
martH <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")
humanEns2humanSymbol <- getBM(attributes = c("ensembl_gene_id", "hgnc_symbol"), mart = martH)

#merge lists and rename column
topGenesRat2humanEns <- merge(topGenes, rat2humanEnsembl, by.x="geneID", by.y="ensembl_gene_id",
                              sort=FALSE)
topGenesRat2humanSymbol <- merge(topGenesRat2humanEns, humanEns2humanSymbol, by.x = "hsapiens_homolog_ensembl_gene", by.y = "ensembl_gene_id",
                                 sort = FALSE)
topGenesRat2humanSymbol <- rename(topGenesRat2humanSymbol, rat_gene_symbol = gene.name)

topGenesRat2humanSymbol <- rename(topGenesRat2humanSymbol, rat_ensembl_gene = geneID)
#export list of human homologs
write.csv(topGenesRat2humanSymbol, file = "top48genes_biomaRt_rat2human.csv")

#find different gene names between the rat and human homologs
topGenesRat2humanSymbol$rat_gene_symbol <- toupper(topGenesRat2humanSymbol$rat_gene_symbol)
rat2humanDiff <- topGenesRat2humanSymbol$rat_gene_symbol[!(topGenesRat2humanSymbol$rat_gene_symbol %in% topGenesRat2humanSymbol$hgnc_symbol)]
#returns ZFP189
rat2humanDiffRev <- topGenesRat2humanSymbol$hgnc_symbol[!(topGenesRat2humanSymbol$hgnc_symbol %in% topGenesRat2humanSymbol$rat_gene_symbol)]
#returns ZNF189


#check if any gene has more or less than 1 homolog
n.occurtopGenesRat2human <- data.frame(table(topGenesRat2humanSymbol$rat_ensembl_gene))
n.occurtopGenesRat2human[n.occurtopGenesRat2human$Freq != 1,]
#                 Var1 Freq
#12 ENSRNOG00000007390    0 - Nfkbia

##############################################################################################################################################
##############################################################################################################################################

#"SALMON" WGCNA MODULE
# RAT => MOUSE

#rat Ensembl IDs to mouse Ensembl IDs
martR <- useMart("ensembl", dataset="rnorvegicus_gene_ensembl")
salRat2mouseEnsembl <- getBM(attributes=c("ensembl_gene_id","mmusculus_homolog_ensembl_gene"),
                          mart=martR)

#mouse Ensembl IDs to mouse (MGI) gene symbols
martM <- useMart("ensembl", dataset = "mmusculus_gene_ensembl")
salMouseEns2mouseSymbol <- getBM(attributes = c("ensembl_gene_id", "mgi_symbol"), mart = martM)

#merge lists and rename column
salmonRat2MouseEns <- merge(salmonSymbols, salRat2mouseEnsembl, by.x="x", by.y="ensembl_gene_id",
                              sort=FALSE)
salmonRat2MouseSymbol <- merge(salmonRat2MouseEns, salMouseEns2mouseSymbol, by.x = "mmusculus_homolog_ensembl_gene", by.y = "ensembl_gene_id",
                                 sort = FALSE)
salmonRat2MouseSymbol <- rename(salmonRat2MouseSymbol, rat_gene_symbol = gene.name)

salmonRat2MouseSymbol <- rename (salmonRat2MouseSymbol, rat_ensembl_gene = x)

salmonRat2MouseSymbol <- select(salmonRat2MouseSymbol, c("rat_ensembl_gene", "mmusculus_homolog_ensembl_gene", "mgi_symbol", "rat_gene_symbol"))


#export list of mouse homologs
write.csv(salmonRat2MouseSymbol, file = "salmonModule_biomaRt_rat2mouse.csv")

#find different gene names between the rat and mouse homologs
salrat2MouseDiff <- salmonRat2MouseSymbol$rat_gene_symbol[!(salmonRat2MouseSymbol$rat_gene_symbol %in% salmonRat2MouseSymbol$mgi_symbol)]
#[1] RGD1311899   Rcor2l1      Spag5        LOC100912481 LOC100911313
# 80 Levels: Amer2 Apcdd1 Apold1 Arc Arid3b Arl4d Atf3 Bcl6 Borcs5 Cacng5 Ccdc117 Ccdc184 Ccn1 Cd180 Cdc40 Cebpa Cep97 Cited2 Clec14a ... Zfp521

salmonRat2MouseDiffRev <- salmonRat2MouseSymbol$mgi_symbol[!(salmonRat2MouseSymbol$mgi_symbol %in% salmonRat2MouseSymbol$rat_gene_symbol)]
#[1] "2210016L21Rik" "Nat8f6"        "Nat8f7"        "Rcor2"         "Rskr"          "Ewsr1"         "Rmdn3"

#check if any gene has more or less than 1 homolog
n.occurSalmonRat2Mouse <- data.frame(table(salmonRat2MouseSymbol$rat_ensembl_gene))
n.occurSalmonRat2Mouse[n.occurSalmonRat2Mouse$Freq != 1,]
# Var1 Freq
# 18 ENSRNOG00000007390    0 - Nfkbia
# 41 ENSRNOG00000015763    3 - Nat8f3
# 75 ENSRNOG00000055673    0 - Gpr52
###########################################################################################
# RAT => HUMAN

#rat Ensembl IDs to human Ensembl IDs
martR <- useMart("ensembl", dataset="rnorvegicus_gene_ensembl")
salRat2humanEnsembl <- getBM(attributes=c("ensembl_gene_id","hsapiens_homolog_ensembl_gene"),
                          mart=martR)

#human Ensembl IDs to human (HGNC) gene symbols
martH <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")
salHumanEns2humanSymbol <- getBM(attributes = c("ensembl_gene_id", "hgnc_symbol"), mart = martH)

#merge lists and rename column
salmonRat2humanEns <- merge(salmonGenes, salRat2humanEnsembl, by.x="x", by.y="ensembl_gene_id",
                              sort=FALSE)
salmonRat2humanSymbol <- merge(salmonRat2humanEns, salHumanEns2humanSymbol, by.x = "hsapiens_homolog_ensembl_gene", by.y = "ensembl_gene_id",
                                 sort = FALSE)

salmonRat2humanSymbol <- merge(salmonRat2humanSymbol, salmonSymbols, by = "x" )

salmonRat2humanSymbol <- rename(salmonRat2humanSymbol, rat_gene_symbol = gene.name)

salmonRat2humanSymbol <- rename(salmonRat2humanSymbol, rat_ensemble_gene = x)

salmonRat2humanSymbol <- select(salmonRat2humanSymbol, c("rat_ensemble_gene", "hsapiens_homolog_ensembl_gene", "hgnc_symbol", "rat_gene_symbol"))

#export list of human homologs
write.csv(salmonRat2humanSymbol, file = "salmonModule_biomaRt_rat2human.csv")

#find different gene names between the rat and human homologs
salmonRat2humanSymbol$rat_gene_symbol <- toupper(salmonRat2humanSymbol$rat_gene_symbol)
salmonRat2humanDiff <- salmonRat2humanSymbol$rat_gene_symbol[!(salmonRat2humanSymbol$rat_gene_symbol %in% salmonRat2humanSymbol$hgnc_symbol)]
# [1] "RGD1311899"   "ZFP189"       "NAT8F3"       "NAT8F3"       "ZFP521"       "RCOR2L1"      "SPAG5"        "LOC100912481" "LOC100911313"
salmonRat2humanDiffRev <- salmonRat2humanSymbol$hgnc_symbol[!(salmonRat2humanSymbol$hgnc_symbol %in% salmonRat2humanSymbol$rat_gene_symbol)]
# [1] "C12orf43" "SIK1B"    "ZNF189"   "NAT8"     "NAT8B"    "ZNF521"   "RCOR2"    "RSKR"     "EWSR1"    "RMDN3"


#check if any gene has more or less than 1 homolog
n.occurSalmonRat2human <- data.frame(table(salmonRat2humanSymbol$rat_ensemble_gene))
n.occurSalmonRat2human[n.occurSalmonRat2human$Freq != 1,]
# Var1 Freq
# 5  ENSRNOG00000001189    2 - Sik1
# 18 ENSRNOG00000007390    0 - Nfkbia
# 41 ENSRNOG00000015763    2 - Nat8f3
# 75 ENSRNOG00000055673    0 - Gpr52
