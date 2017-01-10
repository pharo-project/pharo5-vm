#! /bin/bash

set -e 

baseDir="/appli/files.pharo.org/vm"
case "${ARCH}" in
	macos32x86) 
		destDir="$baseDir/pharo-spur32/mac" 
		;;
	macos64x64) 
		destDir="$baseDir/pharo-spur64/mac" 
		;;
	linux32x86) 
		destDir="$baseDir/pharo-spur32/linux" 
		;;
	linux64x64) 
		destDir="$baseDir/pharo-spur64/linux" 
		;;
	linux32ARMv6) 
		destDir="$baseDir/pharo-spur32/linux/armv6"
		;;
	win32x86) 
		destDir="$baseDir/pharo-spur32/win"
		;;
	win64x64) 
		destDir="$baseDir/pharo-spur64/win"
		;;
	*) 
		echo "Undefined platform!"
		exit 1
esac

productName=`find . -name "pharo-*.zip"`
scp $productName files.pharo.org:$destDir/$productName
scp $productName files.pharo.org:$destDir/latest.zip
