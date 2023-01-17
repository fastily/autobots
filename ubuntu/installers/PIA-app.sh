#!/bin/bash

#: Install the offical PIA app on Ubuntu.
#: 
#: Author: Fastily

PIA_VERSION="3.3.1-06924"
RUN_FILE="pia-linux-${PIA_VERSION}.run"

cd /tmp
wget "https://installers.privateinternetaccess.com/download/${RUN_FILE}" && sh "$RUN_FILE"

piactl background enable