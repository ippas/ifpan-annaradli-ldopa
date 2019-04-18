#!/bin/bash
printf "| file-name | basic-stats | per-base-seq-quality | per-tile-seq-quality | per-seq-quality | per-base-seq-content | per-base-n-content | seq-lenght-distribution | seq-duplication-levels | overrepresented-seq | adapter-content | \n | ------------- | ------------- | --------- | ---------- | ------------ | --------- | -------- | ------- | ------ | ----------- | --------- | " >> qc-report.md
for RAPORT in `ls */summary.txt`
do FILENAME=`echo $RAPORT | cut -d "/" -f 1`
printf "\n | $FILENAME | " >> qc-report.md
for QCRESULT in $(awk -F " " '{print $1}' $RAPORT)
do printf "$QCRESULT | " >> qc-report.md
done
done
printf "\n" >> qc-report.md
