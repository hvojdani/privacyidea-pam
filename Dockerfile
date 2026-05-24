FROM ir-registry.tabdl.cloud/docker.io/ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    make \
    cmake \
    libpam0g-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    pkg-config \
    ca-certificates \    
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

CMD ["/bin/bash"]