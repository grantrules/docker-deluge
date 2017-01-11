FROM ubuntu:latest
MAINTAINER Antoine Rahier <antoine.rahier@gmail.com>

# We don't want anything interactive
ARG DEBIAN_FRONTEND="noninteractive"

# Environment variables
ENV PYTHON_EGG_CACHE="/config/plugins/.python-eggs"

# Update and get dependencies + cleanup
RUN \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
      deluged \
      deluge-web && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

# Copy needed files
COPY root/ /

# Initial install
RUN /init.sh

# Ports
EXPOSE 8112/tcp 58846/tcp 65001/tcp 65001/udp

# Volumes
VOLUME /config /data
