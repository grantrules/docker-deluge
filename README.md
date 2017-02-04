# docker-deluge
Docker container for Deluge torrent client, based on latest Alpine Linux

# Usage
```sh
docker run \
-d \
--name deluge \
-e DELUGE_UID=<user id> \
-e DELUGE_GID=<group id> \
-p 8112:8112/tcp \
-p 58846:58846/tcp \
-p 53160:53160/tcp \
-p 53160:53160/udp \
-v <path/to/deluge/config>:/config \
-v <path/to/data/folder>:/data \
twanislas/deluge
```

## Parameters
- `-e DELUGE_UID=<user id>` The user id of the `deluge` user created inside the container. This will default to `2000` if you don't set it.
- `-e DELUGE_GID=<group id>` The group id of the `deluge` group created inside the container. This will default to `2000` if you don't set it.
- `-p ####:####` Forwards ports from the host to the container.
  - `8112` Web interface port.
  - `58846` Daemon remote port. For example if you want to use the GTK application on your desktop to connect to the daemon running on another machine.
  - `53160` Incoming connections port (that's the one you want to forward in your router to be able to seed).
- `-v <path/to/deluge/config>:/config` This is the path where you want to store Deluge's configuration
- `-v <path/to/data/folder>:/data` This is the path where you want to store your downloads. By default unfinished downloads will go in a `.tmp` subfolder and will be moved to the main folder upon completion.
