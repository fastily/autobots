#!/bin/bash

#: Convert common movie files (mp4, mov, mts) to theora-vorbis
#: 
#: Tested on Ubuntu Server 16.10
#: Author: Fastily

# Set bash case-insensitivity and set non-matching patterns to expand to nothing
shopt -s globstar nullglob nocaseglob

##
# Print program help and exit
##
usage()
{
	printf "Usage:\n"
	printf "%s [-m] [-h]\n" "${0##*/}"
	printf "\t-m: Turn audio transcoding on (off by default)\n"
	printf "\t-h: Show this message and exit\n"
	exit 1
}

## Flag which toggles audio
aSet="-an"

while getopts "mh" flag; do
	case "$flag" in
		m) aSet='-c:a libvorbis -q:a 8' ;;
		h) usage ;;
		*) usage ;;
	esac
done


cd "$PWD"

for f in **/*.{mp4,mov,mts}; do
	printf '%s\n[INFO]: transcoding "%s"...\n' "$(date)" "$f"
	ffmpeg -i "$f" -c:v libtheora -q:v 8 $aSet -map_metadata -1 -loglevel panic "${f%.*}.ogv"
done