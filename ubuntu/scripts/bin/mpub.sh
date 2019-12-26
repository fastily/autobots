#!/bin/bash

#: Sets permissions of items the owned by the current user in $arr to a+r
#: 
#: Tested on Ubuntu Server 17.04.
#: Author: Fastily

ME=$( whoami )

arr=("${HOME}/Public" "/mnt/junk/lol")

for f in "${arr[@]}"; do
	if [ -d "$f" ]; then
		printf "Recursively setting contents of %s to a+r\n" "$f"

		find "$f" -type f -user "$ME" -exec chmod 644 {} +
		find "$f" -type d -user "$ME" -exec chmod 755 {} +
	fi
done

printf "Done!\n"