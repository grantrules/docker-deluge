FROM twanislas/base-alpine:latest
MAINTAINER Antoine Rahier <antoine.rahier@gmail.com>

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="docker-deluge" \
      org.label-schema.description="Docker container for Deluge torrent client, based on latest Alpine Linux" \
      org.label-schema.url="https://github.com/Twanislas/docker-deluge" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/Twanislas/docker-deluge" \
      org.label-schema.vendor="Antoine Rahier" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

# Add repos and install what we need
RUN \
  echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk upgrade --no-cache && \
  apk add --no-cache py-pip deluge@testing && \
  pip install -U pip && \
  pip install service_identity attr

# Copy needed files
COPY rootfs/ /

# Ports
EXPOSE 8112/tcp 58846/tcp 53160/tcp 53160/udp

# Volumes
VOLUME /config /data
