### Sashimi plots for: Sgk1, Mmp9, Per1 i Slc2a1


1. ggsashimi was run in a docker container: `docker pull guigolab/ggsashimi`, a new gft file was downloaded `wget ftp://ftp.ensembl.org/pub/release-101/gtf/rattus_norvegicus/Rattus_norvegicus.Rnor_6.0.101.gtf.gz`

2. To get the pl-ots:

`docker run -w $PWD -v $PWD:$PWD guigolab/ggsashimi -b bam_list.tsv -c 1:24185435-24302298 -g data/Rattus_norvegicus.Rnor_6.0.90.exon.gtf -O 3 -M 10 -C 3 -O 3 --shrink --alpha 0.25 --base-size=20 --ann-height=4 --height=3 --width=18 -P palette.txt --fix-y-scale -F svg -A mean_j`





3. Coordinates: 

x Sgk1 : chr1:24185435 - 24302298
