#!/bin/bash

#: Installs darktable from their ppa.
#: 
#: Tested on Ubuntu Desktop 16.04.3
#: Author: Fastily

sudo add-apt-repository -y ppa:pmjdebruijn/darktable-release && \
sudo apt-get update && \
sudo apt-get -y install darktable