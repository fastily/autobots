#!/bin/bash

#: Convert common movie files (mp4, mov, mts) to vp9/vorbis.
#: Configuration should be good enough for most video @ 1080p60fps
#: 
#: Tested on Ubuntu Server 16.10
#: Author: Fastily

# Set bash case-insensitivity and set non-matching patterns to expand to nothing
shopt -s nullglob nocaseglob

##
# Print program help and exit
##
usage()
{
	printf "Usage:\n"
	printf "toWebm.sh [-m] [-h]\n"
	printf "\t-m: Turn audio transcoding on (off by default)\n"
	printf "\t-h: Show this message and exit\n"
	exit 1
}

## Flag which toggles audio
aSet="-an"

while getopts "mh" flag; do
	case "$flag" in
		m) aSet="-c:a libvorbis -q:a 8" ;;
		h) usage ;;
		*) usage ;;
	esac
done


cd "$PWD"

for f in *.{mp4,mov,mts}; do 
	ffmpeg -y -i "$f" -c:v libvpx-vp9 -pass 1 -b:v 30000K -threads 3 -speed 4 -tile-columns 0 -frame-parallel 0 -g 9999 -aq-mode 0 -an -f webm /dev/null && 
	ffmpeg -i "$f" -c:v libvpx-vp9 -pass 2 -b:v 30000K -threads 3 -speed 0 -tile-columns 0 -frame-parallel 0 -auto-alt-ref 1 -lag-in-frames 25 -g 9999 -aq-mode 0 "$aSet" -f webm "${f%.*}.webm"
done