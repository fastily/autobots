#!/bin/bash

#: Installs/updates my scripts in ~/bin.
#:
#: Author: Fastily

cd "${0%/*}" &> /dev/null
rsync -avhP "../../shared/scripts/" ~/bin