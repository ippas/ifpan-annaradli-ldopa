#!/bin/bash

for FILE in `ls bam/*.sort.bam`
do docker run -d --rm -v $PWD:/data octavianus90/cufflinks_final:latest cuffquant -o /data/cuffquant/$FILE /data/rn6-ind/Rattus_norvegicus.Rnor_6.0.90.gtf /data/$FILE
echo I have started  cuffquant on $FILE
done
