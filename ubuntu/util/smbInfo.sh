#!/bin/bash

#: Grabs current smb info and dumps it into terminal
#: 
#: Tested on Ubuntu Server 15.10.  
#: Author: Fastily

if [ "$EUID" -ne 0 ]; then
	printf "[ERROR]: Script must be run as root (sudo)\n"
	exit
fi


printf "Listing smb statuses"
smbstatus
pdbedit -L -v
smbtree