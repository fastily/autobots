#!/bin/bash

#: Convert common movie files (mp4, mov, mts) to vp9/vorbis.  Targets higher quality and sane-ish file size.
#: Configuration should be good enough for most video @ 1080p60fps
#: 
#: Author: Fastily

# Set bash case-insensitivity and set non-matching patterns to expand to nothing
shopt -s globstar nocaseglob nullglob

##
# Print program help and exit
##
usage()
{
    printf "Usage: %s [-a] [-s] [-h]\n" "${0##*/}"
    printf "\t-a: Turn audio transcoding on (off by default)\n"
    printf "\t-s: Enable slow-motion encoding (8x slowdown @ 30fps)\n"
    printf "\t-h: Show this message and exit\n"
    exit 1
}

SHARED_OPTS="-y -c:v libvpx-vp9 -b:v 0 -crf 24 -tile-columns 2 -threads 8 -cpu-used 2 -map_metadata -1 -loglevel panic"
audio_config="-an"

while getopts "ahs" flag; do
    case "$flag" in
        a)
            audio_config='-c:a libvorbis -q:a 8'
            ;;
        s)
            slow_mo_config="1"
            ;;
        *)
            usage
            ;;
    esac
done

cd "$PWD"

for f in **/*.{mp4,mov,mts}; do
    echo "$(date) [INFO]: transcoding '${f}'..."

    if [[ $slow_mo_config ]]; then
        ffmpeg -i "$f" $SHARED_OPTS -an -r 30 -vf 'setpts=8*PTS' "${f%.*}.webm"
    else
        ffmpeg -i "$f" $audio_config $SHARED_OPTS "${f%.*}.webm"
    fi
done