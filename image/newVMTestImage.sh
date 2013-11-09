#!/bin/bash

set -e

wget http://files.pharo.org/vm/src/vm-test-image-20.zip 1>&2
unzip vm-test-image-20.zip -d vm-test-image 1>&2

	
wget http://files.pharo.org/sources/PharoV20.sources --output-document=vm-test-image/PharoV20.sources 1>&2

PHARO_IMAGE=`find vm-test-image -name \*.image` 1>&2

echo $PHARO_IMAGE
