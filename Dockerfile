FROM twanislas/base-alpine:latest
MAINTAINER Antoine Rahier <antoine.rahier@gmail.com>

# Add repos and install what we need
RUN \
  echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk upgrade --no-cache && \
  apk add --no-cache py2-service_identity deluge@testing

# Copy needed files
COPY rootfs/ /

# Ports
EXPOSE 8112/tcp 58846/tcp 53160/tcp 53160/udp

# Volumes
VOLUME /config /data
