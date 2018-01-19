#!/bin/bash

#: Installs deluge from their ppa.
#: 
#: Tested on Ubuntu Desktop 16.04.3
#: Author: Fastily

sudo add-apt-repository ppa:pmjdebruijn/darktable-release && \
sudo apt-get update && \
sudo apt-get install darktable