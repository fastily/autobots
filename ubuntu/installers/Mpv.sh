#!/bin/bash

#: Installs MPV from their ppa.
#: 
#: Tested on Ubuntu Desktop 16.04.4
#: Author: Fastily

sudo add-apt-repository -y ppa:mc3man/mpv-tests && \
sudo apt-get update && \
sudo apt-get -y install mpv