#!/usr/bin/env bash

##
#: Recursively deletes .DS_STORE from the specified directory.  Defaults to searching the current working directory.
#: 
#: PARAMETERS:
#: 		$1 - Directory to look in.  Optional, leave blank to disable.
#:
#: Author: Fastily
##

d="${1:-.}"
echo "[INFO]: Recursively deleting '.DS_STORE' from '${d}'"
find "$d" -path '*/.Trashes' -prune -o -name '*.DS_Store' -type f -exec rm -v {} +