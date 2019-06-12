# ifpan-annaradli-ldopa

## Rat model of Parkinson - Prefrontal Cortex RNAseq (tissue collected from both hemispheres, n = 5 group, left(L):ipsilateral, right(P):contralateral, 6-OHDHA applied to Medial Forebrain Bundle)

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

### sample quality control extra info
Warnings were not put in the table above and fails in sequence duplication levels were ignored. See [full table](qc-report.md). Fails in per tile sequence quality are common for RNAseq and should not cause major problems.

### Sample list (sample stored in /home/ifpan/projects/ifpan-annaradli-ldopa/data/fq)

 | file-name | group | number-of-lines | number-of-reads | qc-info |
 | -------- | ------- | ------- | --------- | -----------|
 | L10starL_1 | ctrl | 7522016 | 1880504 | FAIL per tile sequence quality  |
 | L10starL_2 | ctrl | 7887509 | 1971877 |  |
 | L10starP_1 | ctrl | 8887800 | 2221950 | FAIL per tile sequence quality |
 | L10starP_2 | ctrl | 9160129 | 2290032 |  |
 | L11starL_1 | ctrl | 8050047 | 2012511 | FAIL per tile sequence quality |
 | L11starL_2 | ctrl | 8471461 | 2117865 |  |
 | L11starP_1 | ctrl | 8357550 | 2089387 | FAIL per tile sequence quality |
 | L11starP_2 | ctrl | 8887780 | 2221945 |  |
 | L1starL_1 | exp | 8037047 | 2009261 |  |
 | L1starL_2 | exp | 8178826 | 2044706 |  |
 | L1starP_1 | exp | 6906544 | 1726636 |  |
 | L1starP_2 | exp | 7039064 | 1759766 |  |
 | L23L_1 | ctrl | 7263462 | 1815865 |  |
 | L23L_2 | ctrl | 7421826 | 1855456 |  |
 | L23P_1 | ctrl | 6633670 | 1658417 |  |
 | L23P_2 | ctrl | 6799405 | 1699851 |  |
 | L2starL_1 | exp | 8001306 | 2000326 |  |
 | L2starL_2 | exp | 8190331 | 2047582 |  |
 | L2starP_1 | exp | 7886468 | 1971617 |  |
 | L2starP_2 | exp | 8086462 | 2021615 |  |
 | L32L_1 | ctrl | 9531600 | 2382900 |  |
 | L32L_2 | ctrl | 10078742 | 2519685 |  |
 | L32P_1 | ctrl | 9300968 | 2325242 |  |
 | L32P_2 | ctrl | 9579047 | 2394761 |  |
 | L39L_1 | ctrl | 9055155 | 2263788 | FAIL per tile sequence quality |
 | L39L_2 | ctrl | 9759042 | 2439760 |  |
 | L39P_1 | ctrl | 7215421 | 1803855 |  |
 | L39P_2 | ctrl | 7436127 | 1859031 |  |
 | L4starL_1 | exp | 7286464 | 1821616 |  |
 | L4starL_2 | exp | 7577632 | 1894408 |  |
 | L4starP_1 | exp | 10417194 | 2604298 |  |
 | L4starP_2 | exp | 10729331 | 2682332 |  |
 | L5starL_1 | exp | 7972285 | 1993071 |  |
 | L5starL_2 | exp | 8299124 | 2074781 |  |
 | L5starP_1 | exp | 7173547 | 1793386 |  |
 | L5starP_2 | exp | 7287402 | 1821850 |  |
 | L6starL_1 | exp | 6479618 | 1619904 |  |
 | L6starL_2 | exp | 6593315 | 1648328 |  |
 | L6starP_1 | exp | 7200807 | 1800201 |  |
 | L6starP_2 | exp | 7349488 | 1837372 |  |

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
