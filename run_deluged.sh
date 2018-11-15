#!/usr/bin/env bash

echo "Starting Deluge Bittorrent Daemon."
export PYTHON_EGG_CACHE="/config/plugins/.python-eggs"

if [ ! -f /config/core.conf ]; then
  cp /deluge-core.conf /config/core.conf
  # TODO Add default config for deluge-web
fi

chown -R deluge:deluge /config /data


#[[ "${DELUGE_UID:-""}" =~ ^[0-9]+$ ]] && usermod -u $DELUGE_UID -o deluge
#[[ "${DELUGE_GID:-""}" =~ ^[0-9]+$ ]] && groupmod -g $DELUGE_GID -o deluge

umask 002
exec deluged -d -c /config -l /config/daemon.log -L debug
#exec su -l deluge -s /bin/bash -c "exec deluged -d -c /config -l /config/daemon.log -L debug"
