# syntax = edrevo/dockerfile-plus

FROM osrf/ros:noetic-desktop-full

ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /workspace

# Install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    git \
    ninja-build \
    vim-tiny \
    && rm -rf /var/lib/apt/lists/*

INCLUDE+ nvidia.Dockerfile

WORKDIR /workspace
CMD ["bash"]

INCLUDE+ ros.Dockerfile
INCLUDE+ user.Dockerfile
