#!/usr/bin/env bash

#: Installs/updates my scripts in ~/bin.
#:
#: Author: Fastily

cd "${0%/*}" &> /dev/null
set -e

rsync -avhP "../../shared/scripts/" ~/"bin"
rsync -avhP "./bash_aliases.sh" ~/".bash_aliases"

echo "Done!"