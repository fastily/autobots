#!/bin/bash

#: Installs qBittorrent from their ppa.
#: 
#: Tested on Ubuntu Desktop 18.04
#: Author: Fastily

set -e

sudo add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable
sudo apt update
sudo apt install -y qbittorrent