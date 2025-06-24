#!/usr/bin/env bash

##
#: Checks the clipboard for a YouTube link, which, if present, downloads the video to /tmp and then opens the directory.
#:
#: Author: Fastily
##

set -e

target=$(pbpaste)

if [[ -n $target ]] && [[ $target =~ "https://www.youtube.com/watch?v=".+ ]]; then
    echo "INFO: now downloading '${target}'"
    cd /tmp
    yt-dlp "$target"
    open .
else
    echo "ERROR: '${target}' is not a valid yt link"
fi