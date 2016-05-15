#!/bin/bash

#: Creates a new SMB user, or changes the password of an existing user.
#: 
#: PRECONDITIONS: 
#:		1) Samba is installed.
#:
#: ARGUMENTS:
#: 		$1 - The username to create or change the SMB password for.
#: 
#: Tested on Ubuntu 15.10
#: Author: Fastily


cd "${0%/*}"
source ../../shared/autobotUtils.sh
confirmRunAsRoot

if[ -z "$1" ] then;
	printf "Usage: addSMBUser <username>\n"
	exit 1
fi

smbpasswd -a "$1"