#!/bin/bash

##
#: Recursively deletes .DS_STORE from the current directory.
#:
#: Author: Fastily
##

printf "Recursively deleting .DS_STORE\n"
find . -name '*.DS_Store' -type f -delete

printf "Done!\n"