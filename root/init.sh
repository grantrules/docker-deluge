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
  if [ ! "$(id -u deluge-web)" -eq "${DELUGE_UID}" ]; then
    # Change the UID and home
    usermod -o -u "${DELUGE_UID}" -d /config deluge-web
  fi
fi
if [ ! -z "${DELUGE_GID}" ]; then
  if [ ! "$(id -g deluge-web)" -eq "${DELUGE_GID}" ]; then
    groupmod -o -g "${DELUGE_GID}" deluge-web
  fi
fi

# Update ownership of dirs we need to write to
chown -R deluge-web:deluge-web /config

# Install the service
update-rc.d deluge-daemon defaults

# We're done here
touch /.firstRunComplete
echo "Deluge setup complete"
