#!/bin/bash

#: Sets permissions of items the owned by the current user in ~/Public and/or /mnt/stuff to a+r
#: 
#: Tested on Ubuntu Server 17.04.
#: Author: Fastily

ME=$( whoami )

declare -a arr=("${HOME}/Public" "/mnt/stuff")

for f in "${arr[@]}"; do
	if [ -d "$f" ]; then
		printf "Recursively setting contents of %s to a+r\n" "$f"

		find "$f" -type f -user "$ME" -exec chmod 664 {} +
		find "$f" -type d -user "$ME" -exec chmod 775 {} +
	fi
done

printf "Done!\n"