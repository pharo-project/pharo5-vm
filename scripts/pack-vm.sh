#!/usr/bin/env bash

set -ex

default_arch="i386"
ARCH=$default_arch
PLATFORM=

# ARGUMENT HANDLING ===========================================================
print_usage() {
	echo "Usage: $0 -p [mac32x86|etc.] [-a i386|x86_64]"
	echo ""
	echo " -p 	Platform to pack. This value is required."
	echo " -a 	Architecture to pack. Default is i386"
	echo ""
	echo "This script builds the sources for the VM for the currently running platform."
}

while getopts "hp:a:" option; do 
	case "$option" in
		p) PLATFORM=$OPTARG ;;
		a) ARCH=$OPTARG ;;
		h) 
			print_usage
			exit 1
			;;
		\?)
      		echo "Invalid option: -$OPTARG" >&2
      		exit 1
      		;;
    	:)
      		echo "Option -$OPTARG requires an argument." >&2
      		exit 1
      		;; 
	esac
done

# DEFINE VARIABLES
os="${TRAVIS_OS_NAME}" # this will change with appveyor
zipFileName="`pwd`/../pharo-${os}-${ARCH}.zip"
productDir="../opensmalltalk-vm"
case "${PLATFORM}" in
	linux32x86) 
		productDir="`find $productDir/products -name "5.0-"`" 
		pattern="*"
		;;
	linux64x64) 
		productDir="`find $productDir/products -name "5.0-"`" 
		pattern="*"
		;;
	linux32ARMv6) 
		productDir="`find $productDir/products -name "5.0-"`" 
		pattern="*"
		;;
	macos32x86) 
		productDir="$productDir/build.${PLATFORM}/pharo.cog.spur" 
		pattern="*.app"
		;;
	macos64x64) 
		productDir="$productDir/build.${PLATFORM}/pharo.cog.spur" 
		pattern="*.app"
		;;
	*) 
		echo "Undefined platform!"
		exit 1
esac

pushd .
cd $productDir
zip -r $zipFileName $pattern
popd