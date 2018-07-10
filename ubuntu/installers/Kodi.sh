#!/bin/bash

#: Installs Kodi from their ppa.
#: 
#: Tested on Ubuntu Desktop 16.04.4
#: Author: Fastily

sudo apt update && \
sudo apt -y install software-properties-common && \
sudo add-apt-repository -y ppa:team-xbmc/ppa && \
sudo apt-get update && \
sudo apt-get -y install kodi