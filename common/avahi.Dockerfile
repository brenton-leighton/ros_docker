# Install avahi packages and useful utilities

RUN apt-get update && apt-get install -q -y --no-install-recommends \
    avahi-daemon \
    avahi-utils \
    iproute2 \
    iputils-ping \
    iputils-tracepath \
    libnss-mdns \
    && rm -rf /var/lib/apt/lists/*
