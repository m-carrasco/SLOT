FROM ubuntu:24.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt install -y git gcc g++ cmake ninja-build python3 zlib1g-dev libtinfo-dev libxml2-dev llvm-16 llvm-16-dev llvm-16-tools z3 libzstd-dev coreutils && \
    rm -rf /var/lib/apt/lists/*

ENV LLVM_DIR=/usr/lib/llvm-16
ENV PATH=$LLVM_DIR/bin:$PATH
ENV LD_LIBRARY_PATH=$LLVM_DIR/lib:$LD_LIBRARY_PATH

COPY src /root/src
RUN cd /root/src/ && make -j$(nproc) && cp slot ../slot
WORKDIR /root