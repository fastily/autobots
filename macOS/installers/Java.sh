#!/usr/bin/env bash

#: Installs my working environment for Java development.
#:
#: Author: Fastily

brew install --cask temurin eclipse-java
brew install gnupg gradle

cd ~
mkdir -p .gradle
ln -sfn ~/Documents/keys/gradle.properties .gradle/gradle.properties
ln -sfn ~/Documents/keys/gnupg .gnupg