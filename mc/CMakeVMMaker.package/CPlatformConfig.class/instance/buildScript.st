build script
buildScript
	"answer the build script for building everything"
	

	^ 
'#!/usr/bin/env bash

cmake .
make

'