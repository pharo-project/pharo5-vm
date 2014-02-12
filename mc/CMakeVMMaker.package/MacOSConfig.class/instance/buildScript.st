build script
buildScript
	"answer the build script for building everything"
	

	^ 
'#!/usr/bin/env bash

if [ ! -e vmVersionInfo.h ]; then
	../scripts/extract-commit-info.sh
fi
cmake .
make
make install

'