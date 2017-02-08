#!/bin/bash

#: Boostrap a fresh install of macOS with all the scripts in this directory.
#: 
#: Tested on macOS 10.12.3
#: Author: Fastily

cd "${0%/*}" &> /dev/null

bash setupHomebrew.sh
bash patchAntiques.sh
bash setupEnv.sh
bash installFFmpeg.sh