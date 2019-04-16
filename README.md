# ifpan-annaradli-ldopa

## Rat model of Parkinson - Medial Forebrain Bundle RNAseq (tissue collected from both hemispheres, n = 5 group)

### Experimental scheme:

* Experimental group: Rats with 6-OHDA-induced Parkinson symptoms (left hemisphere) treated with L-DOPA
* Control group: Rats with 6-OHDA-induced Parkinson symptoms (left hemisphere)

### Animal list
exp: L1star, L2star, L4star, L5star, L6star
ctrl: L10star, L11star, L23, L32, L39

### Sample list (sample stored in /home/ifpan/projects/ifpan-annaradli-ldopa/data/fq)
see attached filest-and-reads.md

### sample quality control
1. Running qc using the pulled docker image: [detailed instructions here](https://hub.docker.com/r/pegi3s/fastqc), see atached script `run-fastqc.sh`

### software + versions + installations
1. [docker installation](https://gist.github.com/gosborcz/f1f3dbd7aa256e26ae1e8ce33fd30509)
2. [pulling docker image with fastqc](https://gist.github.com/gosborcz/1735c2533061354756b05154519972bf), fastqc version=0.11.8


### attached files
1. files-and-reads.md - list of all the samples, with read numbers
2. list-and-count-reads.sh - simple script that lists files, counts reads and makes a .md table
3. run-fastqc.sh - run fastqc on .fq.gz samples in current directory using pegi3/fastqc image
4. fastqc-dockerfile - dockerfiles of the pegi3/fastqc image
