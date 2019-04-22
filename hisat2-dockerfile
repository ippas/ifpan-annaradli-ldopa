# work from latest LTS ubuntu release
FROM ubuntu:18.04

# set environment variables
ENV hisat2_version 2.1.0

# Install dependencies
RUN apt-get update -y && apt-get install -y \
    build-essential \
    libnss-sss \
    vim \
    wget \
    libpthread-stubs0-dev \
    default-jdk \
    python3 \
    python \
    python-pip

# install hisat2
WORKDIR /usr/local/bin
RUN wget https://github.com/DaehwanKimLab/hisat2/archive/v${hisat2_version}.tar.gz
RUN tar -xvzf v${hisat2_version}.tar.gz
WORKDIR /usr/local/bin/hisat2-${hisat2_version}
RUN make
RUN ln -s /usr/local/bin/hisat2-${hisat2_version}/hisat2 /usr/local/bin/hisat2
ENV PATH /usr/local/bin/hisat2-${hisat2_version}hisatgenotype_scripts:${PATH}
ENV PYTHONPATH /usr/local/bin/hisat2-${hisat2_version}/hisatgenotype_modules:${PYTHONPATH}

CMD ["hisat2"]
