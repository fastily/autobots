#!/usr/bin/env bash

#: Installs/updates my scripts in ~/bin.
#:
#: Author: Fastily

cd "${0%/*}" &> /dev/null
set -e

for s in bin ../../shared/scripts; do
    rsync -avhP "${s}/" ~/"bin"
done

rsync -avhP "./bash_aliases.sh" ~/".bash_aliases"

echo "Done!"