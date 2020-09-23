### Sashimi plots for: Sgk1, Mmp9, Per1 i Slc2a1


1. ggsashimi was run in a docker container: `docker pull guigolab/ggsashimi`, a new gft file was downloaded `wget ftp://ftp.ensembl.org/pub/release-90/gtf/rattus_norvegicus/Rattus_norvegicus.Rnor_6.0.101.gtf.gz`

2. To get the plots (example run):

```
docker run -w $PWD -v $PWD:$PWD guigolab/ggsashimi -b bam_list.tsv -o sgk1_part2 -c 1:24214000-24256970 -g data/Rattus_norvegicus.Rnor_6.0.90.exon.gtf -O 3 -C 3 -O 3 --alpha 0.25 --base-size=20 --ann-height=4 --height=3 --width=18 -P palette.txt --fix-y-scale -A mean -M 2 --shrink
```

#note to to this I had to remove gene annotations from the Ensmbl gtf and leave only transcript annotations (sese ggsashimi github for solution)

3. Coordinates: 

* *Sgk1* : 1:24185435-24302298 
for Sgk1 part 1 : 1:24185435-24192200; for part 2: 1:24214000-24256970, for part 3: 1:24300000-24302298
* *Mmp9* : 3:161413298-161421520
