#!/bin/bash

#: Creates a samba share for a user which is only accessible by that user
#:
#: PARAMETERS:
#: 		$1 - path to directory to share.  Please choose a path without spaces for best results.
#: Author: Fastily

if [ "$#" -ne 1 ]; then
	printf "Usage: %s <PATH_TO_DIRECTORY>\n" "${0##*/}"
	exit 1
fi

mkdir -p "$1"

printf "[$( basename "$1" )]
   path = ${1}
   read only = no
   valid users = $(whoami)\n" | sudo tee -a "/etc/samba/smb.conf" > /dev/null

testparm -s && sudo service smbd restart