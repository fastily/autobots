#!/bin/bash

#: Installs Inkscape from their ppa.
#: 
#: Tested on Ubuntu Desktop 16.04.4
#: Author: Fastily

sudo add-apt-repository -y ppa:inkscape.dev/stable && \
sudo apt-get update && \
sudo apt-get install inkscape