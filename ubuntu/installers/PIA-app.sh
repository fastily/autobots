#!/bin/bash

#: Install the offical PIA app on Ubuntu.  Related: https://www.privateinternetaccess.com/pages/changelog
#: 
#: Author: Fastily

runFile="pia-linux-2.0.2-04704.run"

cd /tmp
wget 'https://installers.privateinternetaccess.com/download/${runFile}' && \
chmod a+x "$runFile" && \
./"$runFile"