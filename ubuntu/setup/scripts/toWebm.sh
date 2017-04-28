#!/bin/bash

#: Convert common movie files (mp4, mov, mts) to vp9/vorbis.  Targets higher quality and sane-ish file size.
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
	printf "toWebm.sh [-m] [-o] [-h]\n"
	printf "\t-m: Turn audio transcoding on (off by default)\n"
	printf "\t-o: Specify one pass encoding\n"
	printf "\t-h: Show this message and exit\n"
	exit 1
}

## Flag which toggles audio
aSet="-an"

## Flag to toggle one-pass encode
onePass=false

while getopts "mh" flag; do
	case "$flag" in
		m) aSet='-c:a libvorbis -q:a 8' ;;
		o) onePass=true
		h) usage ;;
		*) usage ;;
	esac
done

cd "$PWD"

if [ "$onePass" = true ]; then
	for f in *.{mp4,mov,mts}; do
		ffmpeg -y -i "$f" -c:v libvpx-vp9 -b:v 0 -crf 24 -threads 4 -speed 0 $aSet -f webm "${f%.*}.webm".webm
	done
else
	for f in *.{mp4,mov,mts}; do 
		ffmpeg -i "$f" -c:v libvpx-vp9 -pass 1 -b:v 42000K -threads 4 -speed 4 $aSet -f webm -y /dev/null && 
		ffmpeg -i "$f" -c:v libvpx-vp9 -pass 2 -b:v 42000K -threads 4 -speed 0 $aSet -f webm "${f%.*}.webm"
	done
fi
