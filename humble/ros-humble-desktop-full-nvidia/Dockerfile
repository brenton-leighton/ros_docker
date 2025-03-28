# syntax = edrevo/dockerfile-plus

FROM osrf/ros:humble-desktop-full

ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /workspace

# Install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    git \
    ninja-build \
    ros-${ROS_DISTRO}-ament-clang-format \
    vim-tiny \
    && rm -rf /var/lib/apt/lists/*

# Copy 10_nvidia.json into the container
# https://github.com/osrf/rocker/blob/main/src/rocker/templates/nvidia_snippet.Dockerfile.em
COPY 10_nvidia.json /usr/share/glvnd/egl_vendor.d/

WORKDIR /workspace
CMD ["bash"]

INCLUDE+ ros.Dockerfile
INCLUDE+ user.Dockerfile
