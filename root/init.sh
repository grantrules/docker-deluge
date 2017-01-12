#!/bin/bash

# If the first run completed successfully, we are done
if [ -e /.firstRunComplete ]; then
  echo "Deluge setup already done"
  exit 0
fi

# Setup directories
mkdir -p /config /data

# Setup user/group ids
if [ ! -z "${DELUGE_UID}" ]; then
  if [ ! "$(id -u debian-deluged)" -eq "${DELUGE_UID}" ]; then
    # Change the UID and home
    usermod -o -u "${DELUGE_UID}" -d /config debian-deluged
  fi
fi
if [ ! -z "${DELUGE_GID}" ]; then
  if [ ! "$(id -g debian-deluged)" -eq "${DELUGE_GID}" ]; then
    groupmod -o -g "${DELUGE_GID}" debian-deluged
  fi
fi

# Update ownership of dirs we need to write to
chown -R debian-deluged:debian-deluged /config

# Install the service
update-rc.d deluge-daemon defaults

# We're done here
touch /.firstRunComplete
echo "Deluge setup complete"
