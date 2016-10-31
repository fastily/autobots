#!/bin/bash

#: Sets up bash aliases.
#: 
#: Tested on OS X 10.11.3
#: Author: Fastily

cd ~
bprofile=".bash_profile"
touch "$bprofile"

## Recusrively deletes .DS_STORE from the current directory
printf "alias ddss=\"find . -name '*.DS_Store' -type f -delete\"\n" >> "$bprofile"

printf "%s updated!\n" "$bprofile"