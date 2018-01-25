#!/bin/bash

#: Installs deluge from their ppa.
#: 
#: Tested on Ubuntu Desktop 16.04.3
#: Author: Fastily

sudo add-apt-repository ppa:deluge-team/ppa && \
sudo apt-get update && \
sudo apt-get -y install deluge

delugeCONFIG="${HOME}/.config/deluge/plugins"

mkdir -p  "$delugeCONFIG" && \
wget -P "${delugeCONFIG}/" 'https://github.com/ratanakvlun/deluge-ltconfig/releases/download/v0.3.1/ltConfig-0.3.1-py2.7.egg'