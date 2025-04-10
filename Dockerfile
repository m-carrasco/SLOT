FROM ubuntu:24.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt install -y git gcc g++ cmake ninja-build python3 zlib1g-dev libtinfo-dev libxml2-dev lsb-release wget software-properties-common gnupg z3 libz3-dev libzstd-dev coreutils && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 20 && \
    rm llvm.sh

ENV LLVM_DIR=/usr/lib/llvm-20
ENV PATH=$LLVM_DIR/bin:$PATH
ENV LD_LIBRARY_PATH=$LLVM_DIR/lib:$LD_LIBRARY_PATH

COPY src /root/src
RUN cd /root/src/ && make -j$(nproc) && cp slot ../slot
WORKDIR /root