#!/bin/bash

#: Convert common movie files (mp4, mov, mts) to vp9/vorbis.  Targets higher quality and sane-ish file size.
#: Configuration should be good enough for most video @ 1080p60fps
#: 
#: Tested on Ubuntu Server 17.04
#: Author: Fastily

# Set bash case-insensitivity and set non-matching patterns to expand to nothing
shopt -s globstar nullglob nocaseglob

##
# Print program help and exit
##
usage()
{
	printf "Usage:\n"
	printf "%s [-a] [-s] [-h]\n" "${0##*/}"
	printf "\t-a: Turn audio transcoding on (off by default)\n"
	printf "\t-s: Enable slow-motion encoding (8x slowdown @ 30fps)\n"
	printf "\t-h: Show this message and exit\n"
	exit 1
}

## Flag which toggles audio
aSet="-an"
enableSlowMo=false

while getopts "ahs" flag; do
	case "$flag" in
		a) aSet='-c:a libvorbis -q:a 8' ;;
		s) enableSlowMo=true ;;
		*) usage ;;
	esac
done

cd "$PWD"

if [ "$enableSlowMo" = true ]; then
	for f in **/*.{mp4,mov,mts}; do
		printf '%s\n[INFO]: transcoding "%s"...\n' "$(date)" "$f"
		ffmpeg -y -i "$f" -c:v libvpx-vp9 -b:v 0 -crf 24 -threads 6 -speed 0 -r 30 -vf "setpts=8*PTS" -an -map_metadata -1 -loglevel panic -f webm "${f%.*}.webm"
	done
else
	for f in **/*.{mp4,mov,mts}; do
		printf '%s\n[INFO]: transcoding "%s"...\n' "$(date)" "$f"
		ffmpeg -y -i "$f" -c:v libvpx-vp9 -b:v 0 -crf 24 -threads 6 -speed 0 $aSet -map_metadata -1 -loglevel panic -f webm "${f%.*}.webm"
	done
fi