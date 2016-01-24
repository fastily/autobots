#!/bin/bash

#: Grabs current smb info and dumps it into terminal
#: 
#: Tested on Ubuntu Server 15.10.  
#: Author: Fastily

cd `dirname "$0"`
source ../../autobotUtils.sh
confirmRunAsRoot

printf "Listing smb statuses\n"
smbstatus
pdbedit -L -v
smbtree