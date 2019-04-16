#!/bin/bash
for FILE in `ls *.fq.gz`
do
docker run --rm -v $PWD:/data pegi3s/fastqc /data/$FILE
done
