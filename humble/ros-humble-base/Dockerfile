# syntax = edrevo/dockerfile-plus

FROM ros:humble-ros-base

ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /workspace

# Install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    git \
    ninja-build \
    ros-${ROS_DISTRO}-ament-clang-format \
    vim-tiny \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
CMD ["bash"]

INCLUDE+ ros.Dockerfile
INCLUDE+ user.Dockerfile
