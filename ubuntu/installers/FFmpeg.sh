#!/bin/bash

#: Installs FFmpeg for ubuntu
#: Must be run as root.
#: This script was derived from [https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu]
#: 
#: Intended for Ubuntu 16.04.4
#: Author: Fastily

## Setting up folder env variables
ffmpegNAME="ffmpeg-4.0"

rootsrc="/tmp/FFMPEG"
src="${rootsrc}/src"
build="${rootsrc}/build"
bin="${HOME}/bin"

## Make the output directories if they don't exist
mkdir -p "$rootsrc" "$src" "$build" "$bin"

## Install FFmpeg and dependencies
sudo apt update

sudo apt -y install autoconf automake build-essential cmake libsdl2-dev libtheora-dev \
libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev \
pkg-config texinfo zlib1g-dev yasm libx264-dev libmp3lame-dev libopus-dev libfdk-aac-dev \
flac mercurial libnuma-dev nasm  ||  { printf "installing dependencies failed, cannot proceed.\n"; exit 1; }

## Install libvpx
cd "$src" && \
git clone --depth 1 'https://chromium.googlesource.com/webm/libvpx' && \
cd libvpx && \
PATH="${bin}:${PATH}" ./configure --prefix="$build" --disable-examples --disable-unit-tests --enable-vp9-highbitdepth --as=yasm && \
PATH="${bin}:${PATH}" make && \
sudo make install

## Install x265
cd "$src" && \
hg clone 'https://bitbucket.org/multicoreware/x265' && \
cd x265/build/linux && \
PATH="${bin}:${PATH}" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$build" -DENABLE_SHARED=off ../../source && \
PATH="${bin}:${PATH}" make && \
sudo make install

## Install FFmpeg
cd "$src" && \
wget "https://www.ffmpeg.org/releases/${ffmpegNAME}.tar.bz2" && \
tar xjvf "${ffmpegNAME}.tar.bz2" && \
cd "$ffmpegNAME"

PATH="${bin}:${PATH}" PKG_CONFIG_PATH="${build}/lib/pkgconfig" ./configure \
 --prefix="$build" \
 --pkg-config-flags="--static" \
 --extra-cflags="-I${build}/include" \
 --extra-ldflags="-L${build}/lib" \
 --extra-libs="-lpthread -lm" \
 --bindir="$bin" \
 --enable-gpl \
 --enable-libfdk-aac \
 --enable-libmp3lame \
 --enable-libopus \
 --enable-libtheora \
 --enable-libvorbis \
 --enable-libvpx \
 --enable-libx264 \
 --enable-libx265 \
 --enable-nonfree

PATH="${bin}:${PATH}" make && \
sudo make install

printf "All done!\n"