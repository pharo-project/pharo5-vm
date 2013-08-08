build script
buildScript
	"answer the build script for building everything"
	

	^ 
'#!bash

cmake .
make

'