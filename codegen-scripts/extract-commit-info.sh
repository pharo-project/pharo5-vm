#!/bin/bash

# by running this script vmVersionInfo.h will be placed in build dir

# -------------------------------------------------------------------------
DIR=`readlink "$0"` || DIR="$0";
DIR=`dirname "$DIR"`;
cd "$DIR"
DIR=`pwd`

VERSION_INFO=$DIR/../build/vmVersionInfo.h
# -------------------------------------------------------------------------

URL=`git config --get remote.origin.url`
COMMIT=`git show HEAD --pretty="Commit: %H Date: %ci By: %cn <%cE>" | head -n 1`

echo -n "#define REVISION_STRING \"$URL $COMMIT " > $VERSION_INFO 
test -n "${BUILD_NUMBER}" && echo -n "Jenkins build #${BUILD_NUMBER}" >> $VERSION_INFO || echo
echo "\"" >> $VERSION_INFO
