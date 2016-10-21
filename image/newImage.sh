#!/usr/bin/env bash

set -ex

# Make Sure we are in the image directory (this script's location) =========
IMAGE_DIR=`readlink "$0"` || IMAGE_DIR="$0";
IMAGE_DIR=`dirname "$IMAGE_DIR"`;
cd "$IMAGE_DIR" 2> /dev/null
IMAGE_DIR=`pwd -P`

# Detect cygwin
# This hack is made to make sure the image can be executed (otherwise image knows is windows
# and threats PATH as win style... and well, it does not finds anything)
OS="`uname -s | cut -b 1-6`"
if [ $OS == "CYGWIN" ]; then
	IMAGE_DIR="."
fi

# PREPARE VM MAKER IMAGE ===================================================
wget -O- get.pharo.org/50+vm | bash

echo -e "LOADING VM MAKER SOURCES INTO IMAGE"
set -x
./pharo Pharo.image "$IMAGE_DIR/../scripts/LoadVMMaker.st"
