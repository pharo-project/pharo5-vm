#!/bin/bash

version="1.4"
image_name="iOS"
if [ "$PHARO_VM" == "" ]; then
	PHARO_VM=pharo
fi

# getting right pharo
sep="-" 
if [ "$version" == "1.4" ]; then
	sep="%20"
fi
file_name="Pharo-$version.zip"
wget --tries=1 --no-check-certificate https://ci.lille.inria.fr/pharo/view/Pharo%20$version/job/Pharo$sep$version/lastSuccessfulBuild/artifact/$file_name

# unzip, move to the right place and rename

dest_dir=Pharo-$version
unzip $file_name
mv $dest_dir/Pharo-$version.image ./$image_name.image
mv $dest_dir/Pharo-$version.changes ./$image_name.changes
mv $dest_dir/PharoV10.sources .
rm -Rf $dest_dir

# preparing for iPhone
$PHARO_VM $image_name.image buildImage.st