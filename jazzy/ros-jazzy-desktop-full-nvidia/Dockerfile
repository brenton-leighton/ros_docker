# syntax = edrevo/dockerfile-plus

FROM osrf/ros:jazzy-desktop-full

ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /workspace

# Install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    git \
    ninja-build \
    ros-${ROS_DISTRO}-ament-clang-format \
    vim-tiny \
    && rm -rf /var/lib/apt/lists/*

INCLUDE+ nvidia.Dockerfile

WORKDIR /workspace
CMD ["bash"]

INCLUDE+ common/ros.Dockerfile
INCLUDE+ common/prompt.Dockerfile
INCLUDE+ common/user.Dockerfile
