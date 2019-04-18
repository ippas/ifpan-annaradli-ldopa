#!/bin/bash
printf " | file_name | number_of_reads | \n | -------- | ------- |" >> files_and_reads.md
for FILE in `ls *.fq.gz`
do
CUTS=`wc -l $FILE | cut -d " " -f 1`
READS=`echo "$CUTS/4" | bc`
printf "\n | $FILE | $READS | " >> files_and_reads.md
done
