#!/usr/bin/env bash

##
#: Recursively rips the audio from video files to mp3.  Default bitrate - 256kbps
#:
#: Author: Fastily
##

# Set bash case-insensitivity and set non-matching patterns to expand to nothing
shopt -s globstar nullglob nocaseglob

##
# Print program help and exit
##
usage()
{
	printf "Usage:\n"
	printf "vidToMp3.sh [-q] [-h]\n"
	printf "\t-q: Force high qulity rips (i.e. 320kbps)\n"
	printf "\t-h: Show this message and exit\n"
	exit
}

## Flag which toggles audio
audioQuality=256

while getopts "qh" flag; do
	case "$flag" in
		q) audioQuality=320 ;;
		*) usage ;;
	esac
done

for f in **/*.{mp4,mov,mts,mkv,webm}; do
	ffmpeg -n -i "$f" -vn -c:a libmp3lame -b:a "${audioQuality}k" -hide_banner "${f%.*}".mp3
done