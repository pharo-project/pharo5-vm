build script
buildScript
	"answer the build script for building everything"
	

	^ 
'#!bash

if [ ! -e vmVersionInfo.h ]; then
	../codegen-scripts/extract-commit-info.sh
fi
cmake .
make
make install

'