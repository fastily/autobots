#!/usr/bin/env bash

##
#: Recursively deletes .DS_STORE from the specified directory.  Defaults to searching the current working directory.
#: 
#: PARAMETERS:
#: 		$1 - Directory to look in.  Optional, leave blank to disable.
#:
#: Author: Fastily
##

[ -z "$1" ] && d="." || d="$1"

printf "Recursively deleting '.DS_STORE' from '%s'\n" "$d"
find "$d" -name '*.DS_Store' -type f -print -delete

echo "Done!"