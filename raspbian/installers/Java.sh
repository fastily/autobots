#!/bin/bash

#: Installs Java 14 on Raspbian.  Using binaries from AdoptOpenJDK: https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
#: 
#: Author: Fastily

cd /tmp

debFile="adoptopenjdk-14-hotspot_14.0.1+7-2_armhf.deb"

wget 'https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/pool/main/a/adoptopenjdk-14-hotspot/${debFile}'
sudo dpkg -i "$debFile"
sudo apt-get install -f -y