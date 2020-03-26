#!/bin/bash

#: Installs Java 14 on Raspbian.  Using binaries from AdoptOpenJDK: https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
#: 
#: Author: Fastily

cd /tmp

wget 'https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/pool/main/a/adoptopenjdk-14-hotspot/adoptopenjdk-14-hotspot_14.0.0+36-2_armhf.deb'
sudo dpkg -i 'adoptopenjdk-14-hotspot_14.0.0+36-2_armhf.deb'
sudo apt-get install -f