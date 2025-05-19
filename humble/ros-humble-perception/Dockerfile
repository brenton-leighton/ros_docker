# syntax = edrevo/dockerfile-plus

FROM ros:humble-perception

ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /workspace

# Install packages
#RUN apt-get update && apt-get install -q -y --no-install-recommends \
#    ros-${ROS_DISTRO}- \
#    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
CMD ["bash"]

INCLUDE+ common/ros.Dockerfile
INCLUDE+ common/prompt.Dockerfile
INCLUDE+ common/user.Dockerfile
