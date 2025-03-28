FROM ros:noetic-robot

ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /workspace

# Install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    avahi-daemon \
    avahi-utils \
    git \
    iproute2 \
    iputils-ping \
    iputils-tracepath \
    libnss-mdns \
    ninja-build \
    vim-tiny \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
CMD ["bash"]
