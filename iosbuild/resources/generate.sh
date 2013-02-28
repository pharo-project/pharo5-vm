#!/bin/bash

version="1.4"
build="14459"
image_name="iOS"
if [ "$PHARO_VM" == "" ]; then
	PHARO_VM=pharo
fi

# getting right pharo
wget --tries=1 --no-check-certificate http://pharo.gforge.inria.fr/ci/image/14/$build.zip

# unzip, move to the right place and rename
unzip -o -j $build.zip
rm $build.zip
mv $build.image ./$image_name.image
mv $build.changes ./$image_name.changes

# preparing for iPhone
$PHARO_VM $image_name.image buildImage.st