#!/bin/bash

#: Installs Java 15 on Raspbian.  Using binaries from AdoptOpenJDK: https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
#: 
#: Author: Fastily

cd /tmp

debFile="adoptopenjdk-15-hotspot_15.0.1+9-3_armhf.deb"

wget 'https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/pool/main/a/adoptopenjdk-15-hotspot/${debFile}'
sudo dpkg -i "$debFile"
sudo apt-get install -f -y