FROM ubuntu:22.04
LABEL description="KAT toolkit built from custom GitHub fork"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git build-essential \
    automake autoconf libtool pkg-config \
    zlib1g-dev libboost-all-dev \
    jellyfish \
    python3 python3-dev python3-pip \
    python3-setuptools python3-distutils \
    && rm -rf /var/lib/apt/lists/*

# Ensure 'python' resolves to python3
RUN ln -sf /usr/bin/python3 /usr/bin/python

# Clone your fork
RUN git clone https://github.com/SaimMomin12/KAT.git /opt/kat
WORKDIR /opt/kat

# Build and install
RUN ./autogen.sh && \
    PYTHON=python3 ./configure && \
    make -j$(nproc) && \
    make install

ENTRYPOINT ["/bin/bash"]
