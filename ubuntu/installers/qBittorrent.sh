#!/bin/bash

#: Installs qBittorrent from their ppa.
#: 
#: Tested on Ubuntu Desktop 18.04
#: Author: Fastily

sudo add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable && \
sudo apt-get update && \
sudo apt-get -y install qbittorrent