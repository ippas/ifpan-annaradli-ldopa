#!/bin/bash
for FILE in `ls *.sam | cut -d "." -f 1`
do
docker run -d --rm -v $PWD:/data zlskidmore/samtools:1.9 samtools sort -O bam -T /data/$FILE.sort -o /data/bam/$FILE.sort.bam /data/$FILE.sam
echo I have started sorting $FILE
done
