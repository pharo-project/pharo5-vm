#!/bin/bash

set -ex

# Make Sure we are in the image directory (this script's location) =========
IMAGE_DIR=`readlink "$0"` || IMAGE_DIR="$0";
IMAGE_DIR=`dirname "$IMAGE_DIR"`;
cd "$IMAGE_DIR" 2> /dev/null
IMAGE_DIR=`pwd -P`

# PREPARE VM MAKER IMAGE ===================================================
wget -O- get.pharo.org/30+vm | bash

echo -e "LOADING VM MAKER SOURCES INTO IMAGE"
set -x
./pharo Pharo.image "$IMAGE_DIR/../scripts/LoadVMMaker.st"
