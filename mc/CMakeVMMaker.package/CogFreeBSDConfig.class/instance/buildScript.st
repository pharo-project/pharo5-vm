as yet unclassified
buildScript
	"answer the build script for building everything"
	

	^ 
'#!/usr/bin/env bash

if [ ! -e vmVersionInfo.h ]; then
	../scripts/extract-commit-info.sh
fi
cmake -DCMAKE_C_COMPILER=/usr/bin/gcc .
make

'