#! /bin/bash

# uploads VMs as "nightly-build". 
# latest builds are in fact built with in opensmaltalk CI, using
# ../opensmalltalk-vm/deploy/pharo/deploy-files.pharo.org

set -ex

destDir="/appli/files.pharo.org/vm/nightly-build"
productName=`ls ./pharo-*.zip`
if [ -z "$productName" ]; then 
	echo "Product not found in `pwd`. Aborting deploy."
	exit 1
fi 
echo "Uploading $productName to pharo.files.org/$destDir"
scp $productName files.pharo.org:$destDir/$productName
