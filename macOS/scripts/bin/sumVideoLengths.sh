#!/usr/bin/env bash

##
#: Calcluate the sum the length (in seconds) of videos in the current directory.  Works for any combination of mkv, mp4, mov, webm, and mts.
#:
#: Author: Fastily
##

secs=$(find . -maxdepth 1 -type f \( -iname \*.mkv -o -iname \*.mp4 -o -iname \*.mov -o -iname \*.webm -o -iname \*.mts \) -exec \
ffprobe -v quiet -of csv=p=0 -show_entries format=duration {} \; | \
paste -sd+ -| \
bc) && \
secs=$(printf "%.0f" $secs) && \
printf '%dh:%dm:%ds\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60))