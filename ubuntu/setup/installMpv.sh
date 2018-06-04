#!/bin/bash

#: Installs MPV from their ppa.
#: 
#: Tested on Ubuntu Desktop 16.04.3
#: Author: Fastily

sudo add-apt-repository ppa:mc3man/mpv-tests && \
sudo apt-get update && \
sudo apt-get install mpv