build script
buildScript
	"answer the build script for building everything"
	

	^ 
'#!bash

if [ ! -e vmVersionInfo.h ]; then
	../codegen-scripts/extract-commit-info.sh
fi
cmake -G Xcode .
xcodebuild -sdk {2} -configuration Release -target {1}

' format: {self executableName. self sdkTarget}