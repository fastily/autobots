#!/usr/bin/env bash

##
#: Recursively rips audio from video files.  Supported formats: mkv,mts,mt2s,webm,ogg,ogv,mp4,mov
#:
#: Author: Fastily
##

# Set bash case-insensitivity and set non-matching patterns to expand to nothing
shopt -s globstar nullglob nocaseglob

##
# Prints log message to std out
# PARAMETERS:
# 		$1 - current file being processed
##
ripMessage() {
	printf '%s\n[INFO]: ripping audio from "%s"...\n' "$(date)" "$1"
}


for f in **/*.{mkv,mts,mt2s,webm,ogv}; do
	ripMessage "$f"
	ffmpeg -n -i "$f" -vn -c:a copy -map_metadata 0 -map_metadata:s:a 0:s:a -loglevel panic "${f%.*}".mka
done

for f in **/*.{mp4,mov}; do
	ripMessage "$f"
	ffmpeg -n -i "$f" -vn -c:a copy -map_metadata 0 -map_metadata:s:a 0:s:a -loglevel panic "${f%.*}".m4a
done
