#!/bin/bash
sudo touch temp.txt
sudo chmod 777 temp.txt
sudo touch temp2.txt
sudo chmod 777 temp2.txt
for FILE in `ls fq/*.fq.gz`
do
echo $FILE |  cut -d "_" -f 1 | tr -d "/fq" >> temp.txt
done
sort temp.txt | uniq >> temp2.txt
sudo rm temp.txt
for FILE in `cat temp2.txt`
do
FILE1=$FILE"_1.fq.gz"
FILE2=$FILE"_2.fq.gz"
docker run -d --rm -v $PWD:/data zlskidmore/hisat2:2.1.0 hisat2 -x /data/rn6-ind/genome -1 /data/fq/$FILE1 -2 /data/fq/$FILE2 -S /data/$FILE.sam --summary-file /data/$FILE.txt --dta-cufflinks
echo I have run hisat2 on $FILE
done
sudo rm temp2.txt
