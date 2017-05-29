#!/bin/bash

#: Installs a .deb package.  Must be run as root.
#: 
#: ARGUMENTS:
#: 		$1 - The path to the .deb file to install.
#:
#: Tested on Ubuntu Server 17.04.
#: Author: Fastily

cd "${0%/*}" &> /dev/null
source ../../shared/autobotUtils.sh
confirmRunAsRoot

dpkg -i "$1"
apt-get install -f
