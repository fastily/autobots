#!/bin/bash

#: Creates a public SMB share using the specified folder.
#:
#: PRECONDITION: Samba is installed.
#: PARAMETERS:
#: 		$1 - path to directory to share.  Please choose a path without spaces for best results.
#: Author: Fastily

if [ "$#" -ne 1 ]; then
	printf "Usage: %s <PATH_TO_DIRECTORY>\n" "${0##*/}"
	exit 1
fi

mkdir -p "$1"
chmod a+rwx "$1"

printf "[$( basename "$1" )]
   path = ${1}
   browseable = yes
   writeable = Yes
   only guest = no
   create mask = 0777
   directory mask = 0777
   public = yes
   guest ok = yes\n" | sudo tee -a "/etc/samba/smb.conf" > /dev/null

testparm -s && sudo systemctl restart smbd