# syntax = edrevo/dockerfile-plus

FROM osrf/ros:noetic-desktop-full

ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /workspace

# Install packages
#RUN apt-get update && apt-get install -q -y --no-install-recommends \
#    ros-${ROS_DISTRO}- \
#    && rm -rf /var/lib/apt/lists/*

INCLUDE+ common/nvidia.Dockerfile

WORKDIR /workspace
CMD ["bash"]

INCLUDE+ common/ros.Dockerfile
INCLUDE+ common/prompt.Dockerfile
INCLUDE+ common/user.Dockerfile
