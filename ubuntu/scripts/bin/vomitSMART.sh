#!/usr/bin/env bash

#: Print detailed SMART info about any drives found.
#: 
#: PRECONDITIONS: 
#:		1) smartmontools is installed and SMART is enabled on all target drives.
#:
#: Author: Fastily

for f in /dev/sd{a..z}; do
	if [[ -b $f ]]; then
		sudo smartctl -x "$f"
	fi
done