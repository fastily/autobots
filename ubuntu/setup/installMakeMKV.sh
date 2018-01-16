#!/bin/bash

#: Installs MakeMKV for Ubuntu.  Not 100% automatic, there will be prompts during the installation.
#: See also: [https://www.makemkv.com/forum2/viewtopic.php?f=3&t=224], [https://www.makemkv.com/forum2/viewtopic.php?f=5&t=1053]
#: 
#: Tested on Ubuntu 16.04.3.
#: Author: Fastily

sudo apt install build-essential pkg-config libc6-dev libssl-dev libexpat1-dev libavcodec-dev libgl1-mesa-dev libqt4-dev libfdk-aac-dev

mkvVERSION="1.10.9"
mkvBIN="makemkv-bin-${mkvVERSION}"
mkvOSS="makemkv-oss-${mkvVERSION}"

BUILD="/tmp/makemkv"

cd "$BUILD"
wget "https://www.makemkv.com/download/${mkvBIN}.tar.gz"
wget "https://www.makemkv.com/download/${mkvOSS}.tar.gz"
wget "https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2"

tar -xvzf "${mkvBIN}.tar.gz"
tar -xvzf "${mkvOSS}.tar.gz"
tar -xvjf "ffmpeg-snapshot.tar.bz2"


cd ffmpeg && \
./configure --prefix="${BUILD}/ffmpeg" --enable-static --disable-shared --enable-pic --disable-yasm --enable-libfdk-aac && \
make install

cd "${BUILD}/${mkvOSS}" && \
PKG_CONFIG_PATH="${BUILD}/ffmpeg/lib/pkgconfig" ./configure && \
make && \
sudo make install

cd "${BUILD}/${mkvBIN}" && \
make && \
sudo make install

printf "Done!\n"