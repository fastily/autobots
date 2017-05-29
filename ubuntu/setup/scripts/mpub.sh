#!/bin/bash

#: Sets permissions of items in ~/Public and /mnt/stuff to a+r
#: 
#: Tested on Ubuntu Server 17.04.  
#: Author: Fastily

printf "Recursively setting contents of ~/Public to a+r\n"

cd ~/Public
find . -type f -exec chmod 664 {} +
find . -type d -exec chmod 775 {} +

printf "Recursively setting contents of /mnt/stuff to a+r\n"
cd /mnt/stuff
find . -type f -exec chmod 664 {} +
find . -type d -exec chmod 775 {} +

printf "Done!\n"
