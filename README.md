# ifpan_annaradli_ldopa

## Rat model of Parkinson - Medial Forebrain Bundle RNAseq (tissue collected from both hemispheres, n = 5 group)

### Experimental scheme:

* Experimental group: Rats with 6-OHDA-induced Parkinson symptoms (left hemisphere) treated with L-DOPA
* Control group: Rats with 6-OHDA-induced Parkinson symptoms (left hemisphere)

### Animal list
exp: L1star, L2star, L4star, L5star, L6star
ctrl: L10star, L11star, L23, L32, L39

### Sample list (sample stored in /home/ifpan/projects/annaradli_ldopa/data/fq_files)

L10starL_1      
L10starL_2      
L10starP_1      
L10starP_2      
L11starL_1      
L11starL_2      
L11starP_1      
L11starP_2      
L1starL_1      
L1starL_2      
L1starP_1      
L1starP_2      
L23L_1      
L23L_2      
L23P_1      
L23P_2      
L2starL_1      
L2starL_2      
L2starP_1      
L2starP_2      
L32L_1      
L32L_2      
L32P_1      
L32P_2      
L39L_1      
L39L_2      
L39P_1      
L39P_2      
L4starL_1      
L4starL_2      
L4starP_1      
L4starP_2      
L5starL_1      
L5starL_2      
L5starP_1      
L5starP_2      
L6starL_1      
L6starL_2      
L6starP_1      
L6starP_2

### sample quality control
1. Running qc using the pulled docker image: [detailed instructions here](https://hub.docker.com/r/pegi3s/fastqc), see atached script `run_fastqc.sh`

### software + versions + installations
1. [docker installation](https://gist.github.com/gosborcz/f1f3dbd7aa256e26ae1e8ce33fd30509)
2. [pulling docker image with fastqc](https://gist.github.com/gosborcz/1735c2533061354756b05154519972bf), fastqc version=0.11.8


### attached files description
1. list_and_count_reads.sh - simple script that lists files, counts reads and makes a .md table
2. run_fastqc.sh - run fastqc on .fq.gz samples in current directory using pegi3/fastqc image
