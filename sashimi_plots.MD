### Sashimi plots for: Sgk1, Mmp9, Per1 i Slc2a1


1. ggsashimi was run in a docker container: `docker pull guigolab/ggsashimi`, a new gft file was downloaded `wget ftp://ftp.ensembl.org/pub/release-90/gtf/rattus_norvegicus/Rattus_norvegicus.Rnor_6.0.101.gtf.gz`

2. To get the plots:

```
docker run -w $PWD -v $PWD:$PWD guigolab/ggsashimi -b bam_list.tsv -o mmp9 -c 3:161413298-161421520 -g data/Rattus_norvegicus.Rnor_6.0.90.exon.gtf -O 3 -C 3 -O 3 --shrink --alpha 0.25 --base-size=20 --ann-height=4 --height=3 --width=18 -P palette.txt --fix-y-scale -A mean
```

#note to to this I had to remove gene annotations from the Ensmbl gtf and leave only transcript annotations (sese ggsashimi github for solution)

3. Coordinates: 

* *Sgk1* : 1:24185435-24302298
* *Mmp9* : 3:161413298-161421520
