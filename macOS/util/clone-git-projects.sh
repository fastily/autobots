#!/bin/bash

#: Clones my git repositories for development.
#:
#: PRECONDITION:
#:		1) my ssh keys have been installed
#:
#: Author: Fastily

GIT_DIR=~/"Documents/git"
WORKSPACE_DIR=~/"Documents/workspace"

mkdir -p "$GIT_DIR" "$WORKSPACE_DIR"


cd "$GIT_DIR"
git clone 'https://github.com/fastily/cli-notebook.git'
git clone 'https://github.com/fastily/fastilybot-toollabs.git'


cd "$WORKSPACE_DIR"
git clone 'https://github.com/fastily/jwiki.git'
git clone 'https://github.com/fastily/fastilybot.git'
git clone 'https://github.com/fastily/mtc.git'
git clone 'https://github.com/fastily/mtc-rest.git'
git clone 'https://github.com/fastily/mw-oauth.git'

git clone 'git@bitbucket.org:fastily/flabs.git'
git clone 'git@bitbucket.org:fastily/spring-course.git'