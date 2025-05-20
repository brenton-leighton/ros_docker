# syntax = edrevo/dockerfile-plus

FROM ros:noetic-perception

ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /workspace

ARG DISTRO="ubuntu2004"
INCLUDE+ common/tensorrt.Dockerfile

# Install packages
#RUN apt-get update && apt-get install -q -y --no-install-recommends \
#    ros-${ROS_DISTRO}- \
#    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
CMD ["bash"]

INCLUDE+ common/ros.Dockerfile
INCLUDE+ common/prompt.Dockerfile
INCLUDE+ common/user.Dockerfile
