#!/bin/bash
printf " \n | file-name | number-of-lines | number-of-reads | qc-info | \n | -------- | ------- | --------- | -----------| " >> sample-info.md
for FILE in `ls *.fq.gz`
do
CUTS=`wc -l $FILE | cut -d " " -f 1`
READS=`echo "$CUTS/4" | bc`
FILENAME=`echo $FILE | cut -d "." -f 1`
printf "\n | $FILENAME | $CUTS | $READS |  | " >> sample-info.md
done
printf "\n" >> sample-info.md
