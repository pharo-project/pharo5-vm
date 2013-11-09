#!/bin/bash

# FIND THIS SCRIPT's LOCATION =================================================
SCRIPT_DIR=`readlink "$0"` || SCRIPT_DIR="$0";
SCRIPT_DIR=`dirname "$SCRIPT_DIR"`;
cd "$SCRIPT_DIR"
SCRIPT_DIR=`pwd -P`

# EXPORT THE VERSION INFO =====================================================

VERSION_INFO="$SCRIPT_DIR/../build/vmVersionInfo.h"
URL=`git config --get remote.origin.url`
COMMIT=`git show HEAD --pretty="Commit: %H Date: %ci By: %cn <%cE>" | head -n 1`

echo -n "#define REVISION_STRING \"$URL $COMMIT " > "$VERSION_INFO" 
test -n "${BUILD_NUMBER}" && echo -n "Jenkins build #${BUILD_NUMBER}" >> "$VERSION_INFO" || echo
echo "\"" >> "$VERSION_INFO"
