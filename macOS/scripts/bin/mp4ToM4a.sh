#!/usr/bin/env bash

##
#: Recursively rips the audio from mp4 videos.  PRECONDITION - All mp4's are using aac for audio.
#:
#: Author: Fastily
##

# Set bash case-insensitivity and set non-matching patterns to expand to nothing
shopt -s globstar nullglob nocaseglob

for f in **/*.mp4; do
	ffmpeg -n -i "$f" -vn -c:a copy -hide_banner "${f%.*}".m4a
done