# Install CUDA and TensorRT
# DISTRO is required, e.g. ARG DISTRO="ubuntu2404"
# CUDA_VERSION and TENSORRT_VERSION can be defined

# Install wget
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install CUDA key
RUN mkdir -p /tmp/cuda && \
    cd /tmp/cuda && \
    wget https://developer.download.nvidia.com/compute/cuda/repos/${DISTRO}/x86_64/cuda-keyring_1.1-1_all.deb && \
    dpkg -i cuda-keyring_1.1-1_all.deb && \
    rm -rf /tmp/cuda

# Install CUDA Toolkit
# https://docs.nvidia.com/cuda/cuda-installation-guide-linux/#ubuntu

ARG CUDA_VERSION="*"

RUN apt-get update && apt-get install -q -y --no-install-recommends \
    cuda-toolkit=${CUDA_VERSION} \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -q -y --no-install-recommends \
    nvidia-gds \
    && rm -rf /var/lib/apt/lists/*

ENV PATH=/usr/local/cuda/bin${PATH:+:${PATH}}

# Install TensorRT
# https://docs.nvidia.com/deeplearning/tensorrt/latest/installing-tensorrt/installing.html#using-the-nvidia-cuda-network-repo-for-debian-installation

ARG TENSORRT_VERSION="*"

RUN apt-get update && apt-get install -q -y --no-install-recommends \
    tensorrt="${TENSORRT_VERSION}" \
    tensorrt-dev="${TENSORRT_VERSION}" \
    && rm -rf /var/lib/apt/lists/*

ENV TENSORRT_ROOT=/usr/src/tensorrt
