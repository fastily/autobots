#!/usr/bin/env bash

##
#: Uses imagemagick to remove an image's white background
#: PARAMETERS:
#: 		$1 - path to image file.  The image should have a white background.
#:
#: Author: Fastily
##

if [ ! -f "$1" ]; then
	printf "Usage: %s <IMAGE_FILE>\n" "${0##*/}"
	exit 1
fi

convert "$1" -fuzz 20% -transparent white "${1%.*} - transparent".png