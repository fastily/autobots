#!/usr/bin/env bash

##
#: Archive a YouTube video, channel, or playlist.  Skips already downloaded content via skip file: archive.txt.
#: PARAMETERS:
#: 		$1 - URL to archive, excluding "https://www.youtube.com/" prefix
##

if [ "$#" -ne 1 ]; then
	printf "Usage: %s <YT_PATH>\n" "${0##*/}"
	exit 1
fi

youtube-dl -i -w --add-metadata --download-archive archive.txt -o '%(upload_date)s - %(title)s - [%(id)s].%(ext)s' "https://www.youtube.com/${1}"