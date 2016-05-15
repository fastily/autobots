#!/bin/bash

#: Grabs current smb info and dumps it into terminal
#: 
#: Tested on Ubuntu Server 15.10.  
#: Author: Fastily

cd "${0%/*}"
source ../../shared/autobotUtils.sh
confirmRunAsRoot

printf "Listing smb statuses\n"
smbstatus
pdbedit -L -v
net usershare info --long
smbtree
