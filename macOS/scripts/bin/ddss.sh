#!/usr/bin/env bash

##
#: Recursively deletes .DS_STORE from the specified directory.  Deletes starting in the current directory by default.
#: 
#: PARAMETERS:
#: 		$1 - Directory to start looking in.  Optional parameter, leave blank to disable.
#: Author: Fastily
##

search="."
if [ $# -gt 0 ]; then
    search="$1"
fi

printf "Recursively deleting '.DS_STORE' from '%s':\n" "$search"
find "$search" -name '*.DS_Store' -type f -print -delete

printf "Done!\n"