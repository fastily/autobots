#!/bin/bash

#: Generic, set up my working environment
#: 
#: Tested on macOS 10.12.1
#: Author: Fastily

cd ~
BPROFILE=".bash_profile"
touch "$BPROFILE"

## Recusrively deletes .DS_STORE from the current directory
printf "alias ddss=\"find . -name '*.DS_Store' -type f -delete\"\n" >> "$BPROFILE"

## Create bin folder in HOME and add it to PATH
mkdir -p bin
printf "PATH=${PATH}:${HOME}/bin\n" >> "$BPROFILE"


printf "%s updated!\n" "$BPROFILE"