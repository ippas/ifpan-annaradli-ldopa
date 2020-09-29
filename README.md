# ifpan-annaradli-ldopa

## Rat model of Parkinson - Prefrontal Cortex RNAseq (tissue collected from both hemispheres, n = 5 group, left(L):ipsilateral, right(P):contralateral, 6-OHDA applied to Medial Forebrain Bundle)

### Experimental scheme:
* Experimental group: Rats with 6-OHDA-induced Parkinson symptoms (left hemisphere) treated with L-DOPA
* Control group: Rats with 6-OHDA-induced Parkinson symptoms (left hemisphere)

### Animal list
* exp: L1star, L2star, L4star, L5star, L6star
* ctrl: L10star, L11star, L23, L32, L39

## Method
*All samples were checked for quality with fastQC v0.11.8 and aligned to a rat reference genome (rn6 from Ensembl database) with hisat2 2.1.0. Cufflinks v 2.2.1 package and GTF from the Ensembl gene database were used to quantify (cuffquant) and normalize (cuffnorm) transcripts to fpkms (Fragments Per Kilobase of transcript per Million fragments mapped). All statisical analyses were performed with R software v3.4. Statistical significance was tested using ANOVA on log2(1 + x) values with false discovery rate adjustment ("FDR" method of p.adjust in R 3.4). Only transcipts with log2(1 + x) > 1 were analysed for significance. Transcript annotation and classification was performed using the BioMart interface to the Ensembl database.*

## Main results
list of all genes with abundance of their transcripts and two-way ANOVA results if applicable is avalable [here](all-genes.csv). Examples of alignments of files from each group can be viewed [here](http://149.156.177.112/projects/ifpan-annaradli-ldopa/alignments.html). Example raw data from four samples (one from each group) can be viewed interactively [here](http://149.156.177.112/projects/ifpan-annaradli-ldopa/alignments.html).

![top differentially expressed genes](https://raw.githubusercontent.com/ippas/ifpan-annaradli-ldopa/master/selected-genes-log.jpg)
**heatmap of top differentially expressed genes (log2(1+fpmk) values were plotted)**

### extra analysis info
For initial exploratory analysis transcripts from the following groups have been compared: L ctrl vs L exp, P ctrl vs P exp, L vs P ctrl, L vs P exp with cuffdiff (results available on server: /home/ifpan/projects/ifpan-annaradli-ldopa/data/cuffdiff). I have also attempted to find genes which expression would correlate with behavior (autorotations) but did not find any. Expression of various transcripts was also analysed and the data is available [here](selected-genes-isoforms.csv). Below you can find two example sashimi plots of genes with more than one transcript (Sgk1 and Zfp189).


![Sgk1 sashimi plot](https://raw.githubusercontent.com/ippas/ifpan-annaradli-ldopa/master/sgk1.png)

![Zfp189 sashimi plot](https://raw.githubusercontent.com/ippas/ifpan-annaradli-ldopa/master/zfp189.png)

Supplemental sashimi plots were generates with [this script](sashimi_plots.MD). Isoform analysis was done [with R](isoforms-analysis.R) similarly to gene analysis.

### sample quality control extra info
Warnings were not put in the table above and fails in sequence duplication levels were ignored. See [full table](qc-report.md). Fails in per tile sequence quality are common for RNAseq and should not cause major problems.

### Sample list (sample stored in /home/ifpan/projects/ifpan-annaradli-ldopa/data/fq)

 | file-name | group | number-of-lines | number-of-reads | qc-info |
 | -------- | ------- | ------- | --------- | -----------|
 | L10starL_1 | ctrl | 99822148 | 24955537 |  FAIL per tile sequence quality | 
 | L10starL_2 | ctrl | 99822148 | 24955537 |  | 
 | L10starP_1 | ctrl | 116924840 | 29231210 | FAIL per tile sequence quality | 
 | L10starP_2 | ctrl | 116924840 | 29231210 |  | 
 | L11starL_1 | ctrl | 106662596 | 26665649 | FAIL per tile sequence quality | 
 | L11starL_2 | ctrl | 106662596 | 26665649 |  | 
 | L11starP_1 | ctrl | 111122660 | 27780665 | FAIL per tile sequence quality | 
 | L11starP_2 | ctrl | 111122660 | 27780665 |  | 
 | L1starL_1 | exp | 106496112 | 26624028 |  | 
 | L1starL_2 | exp | 106496112 | 26624028 |  | 
 | L1starP_1 | exp | 91500636 | 22875159 |  | 
 | L1starP_2 | exp | 91500636 | 22875159 |  | 
 | L23L_1 |  ctrl | 96571180 | 24142795 |  | 
 | L23L_2 |  ctrl | 96571180 | 24142795 |  | 
 | L23P_1 |  ctrl | 87427172 | 21856793 |  | 
 | L23P_2 |  ctrl | 87427172 | 21856793 |  | 
 | L2starL_1 | exp | 106656988 | 26664247 |  | 
 | L2starL_2 | exp | 106656988 | 26664247 |  | 
 | L2starP_1 | exp | 104981692 | 26245423 |  | 
 | L2starP_2 | exp | 104981692 | 26245423 |  | 
 | L32L_1 |  ctrl | 126621900 | 31655475 |  | 
 | L32L_2 |  ctrl | 126621900 | 31655475 |  | 
 | L32P_1 |  ctrl | 124264560 | 31066140 |  | 
 | L32P_2 |  ctrl | 124264560 | 31066140 |  | 
 | L39L_1 |  ctrl | 119760236 | 29940059 | FAIL per tile sequence quality | 
 | L39L_2 |  ctrl | 119760236 | 29940059 |  | 
 | L39P_1 |  ctrl | 95577488 | 23894372 |  | 
 | L39P_2 |  ctrl | 95577488 | 23894372 |  | 
 | L4starL_1 | exp | 96572328 | 24143082 |  | 
 | L4starL_2 | exp | 96572328 | 24143082 |  | 
 | L4starP_1 | exp | 138928448 | 34732112 |  | 
 | L4starP_2 | exp | 138928448 | 34732112 |  | 
 | L5starL_1 | exp | 106451016 | 26612754 |  | 
 | L5starL_2 | exp | 106451016 | 26612754 |  | 
 | L5starP_1 | exp | 95144772 | 23786193 |  | 
 | L5starP_2 | exp | 95144772 | 23786193 |  | 
 | L6starL_1 | exp | 86177384 | 21544346 |  | 
 | L6starL_2 | exp | 86177384 | 21544346 |  | 
 | L6starP_1 | exp | 95858616 | 23964654 |  | 
 | L6starP_2 | exp | 95858616 | 23964654 |  | 





### software + versions + installations
1. [docker installation](https://gist.github.com/gosborcz/f1f3dbd7aa256e26ae1e8ce33fd30509)
2. [pulling docker image with fastqc](https://gist.github.com/gosborcz/1735c2533061354756b05154519972bf), fastqc version=0.11.8
3. Hisat2 2.0.5 for indexing [docker image pulled from docker hub](https://hub.docker.com/r/biocontainers/hisat2) and hisat2 2.1.0 for aligment [docker image from docker hub](https://hub.docker.com/r/zlskidmore/hisat2)
4. Rat reference genome `Rattus_norvegicus.Rnor_6.0.dna.toplevel.fa.gz` to build hisa2 index was downloaded from [ensembl](ftp://ftp.ensembl.org/pub/release-96/fasta/rattus_norvegicus/dna/)
5. gene transfer file `Rattus_norvegicus.Rnor_6.0.90.gtf.gz` for cufflinks was downloaded from [ensembl](ftp://ftp.ensembl.org/pub/release-90/gtf/rattus_norvegicus/)
6. samtools image v 1.9 [pulled from docker hub](https://hub.docker.com/r/zlskidmore/samtools)
7. cufflinks package image v 2.2.1 [pulled from docker hub](https://hub.docker.com/r/octavianus90/cufflinks_final)
8. Picard [pulled from docker hub](https://hub.docker.com/r/broadinstitute/picard)

### attached files
1. [script to generate .md table of samples with reads](generate-sample-info-table.sh)
2. [sh to run fastqc on .fq.gz samples in current directory using pegi3/fastqc image](run-fastqc.sh), [detailed instructions here](https://hub.docker.com/r/pegi3s/fastqc)
3. [dockerfile of the pegi3/fastqc image](fastqc-dockerfile)
4. [script to generate .md table with qc report](generate-summary-qc-table.sh) and [the qc report](qc-report.md)
5. [indexing the reference genome with hisat2](buid-hisat2-index.sh)
6. dockerfiles of hisat2 used for [indexing](hisat2-dockerfile-forindexing) and [aligment] (hisat2-dockerfile-foralignment)
7. [script to run hisat2 on all the sample](run-hisat2.sh)
8. [hisat2 alignment summary for all the samples](hisat2-report.md) generated with [this script](generate-hisat2-report.sh)
9. [samtools docker file](samtools-dockerfile)
10. [script to sort .sam files and convert to .bam](sort-sam.sh)
11. As there was no dockerfile on the cufflinks image [docker-history](cufflinks-dockerhistory) was downloaded as a proxy.
12. [Script to run cuffquant](run-cuffquant.sh)
13. [Commands to run cuffdiff](run-cuffdiff)
14. [Running cuffnorm](run-cuffnorm)
15. [indexing .bam to view in IGV](bam-to-bai.sh)
16. [R code to generate results](rna-seq-analysis.R)
17. [table with fdr of all genes](all-genes.csv) [and of selected genes](selected-genes-log.csv)
18. heatmap of selected genes in [high resolution pdf](selected-genes-log.pdf) and [low resolution jpg](selected-genes-log.jpg)
19. [code to correlate gene expression with autorotations of rats after apomorphine challenges](correlation-with-autorotations.R)
20. [code to analyse transcript abundance of top 48 genes](transcript-analysis.R) and [the results](selected-genes-isoforms.csv) with two sashmi plots to illustrate: [Sgk1](sgk1.png) and [Zfp189](zfp189.png)
21. [html code for the interactive viewer](alignments.html). The main code is at the bottom of the file (large style section at the begining). The interactive version can be viewed [here](http://149.156.177.112/projects/ifpan-annaradli-ldopa/alignments.html)
22. [code for the Weighted Gene Coexpression Network Analysis (WGCNA) of the genes with FPKM > 1](wgcna_analysis.R) and its input files: [table of genes](fpkm_above1_all_samples.csv), [table with Ensembl IDs and gene symbols](ENSRNOG-genename.csv)
23. [Full RNA-seq data](all_genes_FDR_FPKM_samples_sequence_types_WGCNA_modules.xlsx): Genes mapped to the rat Rnor_6.0 genome assembly, with Ensembl IDs, gene symbols, mean and individual log2(FPKM +1) values, false discovery rate (FDR) values for both factors and their interaction, gene classification, and the WGCNA modules to which the genes were assigned.
24. [biomaRt script for finding mouse and human homolog genes for the differentially expressed genes (DEGs) and genes included in the "salmon" WGCNA module](find_homologues.R) and its input files: [table with the DEGs](selected-genes-log.csv) and [table with genes included in the "salmon" WGCNA module](Salmon-symbols.csv). 
The output files: DEGs - [mouse](top48genes_biomaRt_rat2mouse.csv) and [human](top48genes_biomaRt_rat2human.csv); 
"salmon" module - [mice](salmonModule_biomaRt_rat2mouse.csv) and [human](salmonModule_biomaRt_rat2human.csv) homologs.
25. enrichR analysis for the gene ontology and drug-induced expression signature overrepresenation analysis: [DEGs](enrichR_DEGs.R) and [the "salmon" WGCNA module](enrichR_salmon.R). The input files for the scripts are the appropriate output .csv files of  human homolog genes from the biomaRt analysis. 
