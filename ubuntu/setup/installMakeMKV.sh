#!/bin/bash

#: Installs MakeMKV for Ubuntu.  Not 100% automatic, there will be prompts during the installation.
#: See also: [https://www.makemkv.com/forum2/viewtopic.php?f=3&t=224], [https://www.makemkv.com/forum2/viewtopic.php?f=5&t=1053]
#: 
#: Tested on Ubuntu 16.04.3.
#: Author: Fastily

sudo apt -y install build-essential pkg-config libc6-dev libssl-dev libexpat1-dev libgl1-mesa-dev libqt4-dev libfdk-aac-dev #libavcodec-dev

mkvVERSION="1.12.0"
ffmpegVERSION="3.4.1"

ffmpegBIN="ffmpeg-${ffmpegVERSION}"
mkvBIN="makemkv-bin-${mkvVERSION}"
mkvOSS="makemkv-oss-${mkvVERSION}"

BUILD="/tmp/makemkv"
mkdir -p "$BUILD"

cd "$BUILD"
wget "https://www.makemkv.com/download/${mkvBIN}.tar.gz"
wget "https://www.makemkv.com/download/${mkvOSS}.tar.gz"
wget "https://www.ffmpeg.org/releases/${ffmpegBIN}.tar.bz2"

tar -xvzf "${mkvBIN}.tar.gz"
tar -xvzf "${mkvOSS}.tar.gz"
tar -xvjf "${ffmpegBIN}.tar.bz2"


cd "${ffmpegBIN}" && \
./configure --prefix="${BUILD}/${ffmpegBIN}" --enable-static --disable-shared \
--enable-pic --disable-yasm --disable-all --disable-autodetect --disable-everything \
--enable-swresample --enable-avcodec --enable-encoder=flac,aac --enable-decoders --enable-libfdk-aac && \
make install

cd "${BUILD}/${mkvOSS}" && \
PKG_CONFIG_PATH="${BUILD}/${ffmpegBIN}/lib/pkgconfig" ./configure && \
make && \
sudo make install

cd "${BUILD}/${mkvBIN}" && \
make && \
sudo make install

printf "Done!\n"
