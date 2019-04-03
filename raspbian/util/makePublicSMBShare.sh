#!/bin/bash

#: Creates a public SMB share using the specified folder.
#:
#: PRECONDITION: Samba is installed.
#: PARAMETERS:
#: 		$1 - path to directory to share.  Please choose a path without spaces for best results.
#: Author: Fastily

if [ "$#" -ne 1 ]; then
	printf "Usage: makePublicSMBShare <PATH_TO_DIRECTORY>\n"
	exit 1
fi

printf "[$( basename "$1" )]
Path = ${1}
Browseable = yes
Writeable = Yes
only guest = no
create mask = 0777
directory mask = 0777
Public = yes
Guest ok = yes\n" | sudo tee -a "/etc/samba/smb.conf" > /dev/null

/etc/init.d/samba restart