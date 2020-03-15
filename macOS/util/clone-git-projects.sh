#!/usr/bin/env bash

#: Clones my git repositories for development.
#:
#: PRECONDITION:
#:		1) I am logged into git
#:
#: Author: Fastily

GIT_DIR=~/"Documents/git"
# WORKSPACE_DIR=~/"Documents/workspace"

GITHUB='https://github.com/fastily'

##
# Clones and builds Java projects
# PARAMETERS:
# 		$1 - Base URL/path to repository
# 		$2 - name of the project
# 		$3 - additional options to pass to gradle.  Optional - leave blank to disable.
##
cloneAndBuild() {
	git clone "https://github.com/fastily/${1}.git"
	pushd "$1" && \
	gradle build $2
	popd
}


mkdir -p "$GIT_DIR"


## Setup general projects
cd "$GIT_DIR"
git clone "${GITHUB}/backup-utils.git"
git clone "${GITHUB}/cheatsheet.git"
git clone "${GITHUB}/fastilybot-toolforge.git"
git clone "${GITHUB}/fcpx-presets.git"
git clone "${GITHUB}/ip-range-calc.git"
git clone "${GITHUB}/jinja2html"
git clone "${GITHUB}/jwiki-starter"
git clone "${GITHUB}/simple-commons-uploader"
git clone "${GITHUB}/text2hash.git"

## Java projects
cloneAndBuild "jwiki" 'publishToMavenLocal -x test'
cloneAndBuild "wp-toolbox" 'publishToMavenLocal -x test'
cloneAndBuild "fastilybot"
cloneAndBuild "mtc"
cloneAndBuild "flabs"

## Other
git clone "${GITHUB}/bootstrap-course.git"
git clone "${GITHUB}/stardew-valley-saves.git"