#!/bin/bash

for FILE in `ls *.txt`
do printf "\n $FILE "  >> hisat2-report.md
cat $FILE >> hisat2-report.md
done
