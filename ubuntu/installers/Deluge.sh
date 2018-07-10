#!/bin/bash

#: Installs deluge from their ppa.
#: 
#: Author: Fastily

## Newer versions of ubuntu use the latest deluge version
if [[ "$( lsb_release -r -s | tr -d '.' )" -lt 1710 ]]; then
	sudo add-apt-repository -y ppa:deluge-team/ppa && \
	sudo apt-get update && \
	sudo apt-get -y install deluge
else
	sudo apt -y install deluge
fi

delugeCONFIG="${HOME}/.config/deluge/plugins"

mkdir -p  "$delugeCONFIG" && \
wget -P "${delugeCONFIG}/" 'https://github.com/ratanakvlun/deluge-ltconfig/releases/download/v0.3.1/ltConfig-0.3.1-py2.7.egg'