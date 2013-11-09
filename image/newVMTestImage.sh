#!/bin/bash

set -ex

wget http://files.pharo.org/vm/src/vm-test-image-20.zip
unzip vm-test-image-20.zip -d vm-test-image


PHARO_IMAGE=`find vm-test-image -name \*.image`

echo $PHARO_IMAGE
