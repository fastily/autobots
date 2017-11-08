#!/bin/bash

#: Installs deluge from their ppa.
#: 
#: Tested on Ubuntu Desktop 16.04.3
#: Author: Fastily

cd "${0%/*}" &> /dev/null
source ../../shared/autobotUtils.sh
confirmRunAsRoot

add-apt-repository ppa:deluge-team/ppa
apt-get update
apt-get install deluge