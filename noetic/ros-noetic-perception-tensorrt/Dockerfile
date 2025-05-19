# syntax = edrevo/dockerfile-plus

FROM ros:noetic-perception

ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /workspace

# Install wget
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install CUDA key
RUN mkdir -p /tmp/cuda && \
    cd /tmp/cuda && \
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.1-1_all.deb && \
    dpkg -i cuda-keyring_1.1-1_all.deb && \
    rm -rf /tmp/cuda

# Install latest version of TensorRT
# https://docs.nvidia.com/deeplearning/tensorrt/latest/installing-tensorrt/installing.html#using-the-nvidia-cuda-network-repo-for-debian-installation
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    tensorrt-dev \
    && rm -rf /var/lib/apt/lists/*

ENV PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
ENV TENSORRT_ROOT=/usr/src/tensorrt

# Install packages
#RUN apt-get update && apt-get install -q -y --no-install-recommends \
#    ros-${ROS_DISTRO}- \
#    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
CMD ["bash"]

INCLUDE+ common/ros.Dockerfile
INCLUDE+ common/prompt.Dockerfile
INCLUDE+ common/user.Dockerfile
