#!/bin/bash
for FILE in `ls *.sam | cut -d "." -f 1`
do
docker run -d --rm -v $PWD:/data zlskidmore/samtools:1.9 samtools sort -O sam -T /data/$FILE.sort -o /data/$FILE.sort.sam /data/$FILE.sam
echo I have started sorting $FILE
done
