#!/bin/bash

#: Sets permissions of items in ~/Public to a+r
#: 
#: Tested on Ubuntu Server 15.10.  
#: Author: Fastily

printf "Recursively setting contents of ~/Public to a+r\n"

cd ~/Public
find . -type f -exec chmod 664 {} +
find . -type d -exec chmod 775 {} +

printf "Done!\n"
