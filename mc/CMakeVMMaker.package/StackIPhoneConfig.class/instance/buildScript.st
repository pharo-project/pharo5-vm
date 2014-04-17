build script
buildScript
	"answer the build script for building everything"
	

	^ 
'#!/usr/bin/env bash

set -e 

if [ ! -e vmVersionInfo.h ]; then
	../scripts/extract-commit-info.sh
fi
cmake .
make 
find ../{1}/{2}.app/Contents -type f -exec mv ''\{\}'' ../{1}/{2}.app \\;
rm -Rf ../{1}/{2}.app/Contents
' format: { self outputDirName. self executableName }