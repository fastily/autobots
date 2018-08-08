#!/usr/bin/env bash

##
#: Recursively rips audio from video files.  Supported formats: mkv,mts,mt2s,webm,ogg,ogv,mp4,mov
#:
#: Author: Fastily
##

# Set bash case-insensitivity and set non-matching patterns to expand to nothing
shopt -s globstar nullglob nocaseglob

for f in **/*.{mkv,mts,mt2s,webm,ogv}; do
	ffmpeg -n -i "$f" -vn -c:a copy -map_metadata 0 -map_metadata:s:a 0:s:a -hide_banner "${f%.*}".mka
done

for f in **/*.{mp4,mov}; do
	ffmpeg -n -i "$f" -vn -c:a copy -map_metadata 0 -map_metadata:s:a 0:s:a -hide_banner "${f%.*}".m4a
done

# -write_id3v2 1