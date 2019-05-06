#!/bin/bash
for FILE in `ls *.bam`
do
docker run -d --rm -v $PWD:/data zlskidmore/samtools:1.9 samtools index /data/$FILE
done
