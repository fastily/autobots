#!/bin/bash

#: Installs Docker on Raspbian.  Adapted from [https://docs.docker.com/install/linux/docker-ce/debian/#install-using-the-convenience-script]
#: 
#: Author: Fastily

cd /tmp

wget 'https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/pool/main/a/adoptopenjdk-14-hotspot/adoptopenjdk-14-hotspot_14.0.0+36-2_armhf.deb'
sudo dpkg -i 'adoptopenjdk-14-hotspot_14.0.0+36-2_armhf.deb'
sudo apt-get install -f