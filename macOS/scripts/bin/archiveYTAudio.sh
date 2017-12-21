#!/bin/bash

##
#: Archive a YouTube video, channel, or playlist as mp3.  Skips already downloaded content via skip file: archive.txt.
#: PARAMETERS:
#: 		$1 - URL to archive excluding "https://www.youtube.com/" prefix
#: 		$2 - String to set as Album Artist tag in output
#: 		$3 - String to set as Album tag in output
#: 		$4 - Local path to album artwork.  Must be a PNG or JPG.
#:
#: Author: Fastily
##

if [ "$#" -ne 4 ]; then
	printf "Usage: archiveYTAudio <YT_PATH> <ARTIST> <ALUBM> <PATH_TO_ARTWORK>\n"
	exit 1
fi

youtube-dl -i -w -f bestaudio -x --audio-format mp3 --audio-quality 0 --add-metadata \
--download-archive archive.txt -o '%(title)s - [%(id)s].%(ext)s' "https://www.youtube.com/${1}" \
--exec "eyeD3 -A \"${2}\" -b \"${3}\" --add-image \"${4}\":FRONT_COVER {}"