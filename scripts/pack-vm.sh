#!/usr/bin/env bash

set -ex

# This are defined elsewhere (usually in travis):
# 
# ARCH		- macos32x86, linux64x64, etc.
# SRC_ARCH	- i386, x64_86
# HEARTBEAT	- threaded, itimer (or none)

vmVersion="5.0"
productDir="../opensmalltalk-vm"
case "${ARCH}" in
	macos32x86) 
		productDir="$productDir/build.${ARCH}/pharo.cog.spur" 
		pattern="*.app"
		os="mac"
		;;
	macos64x64) 
		productDir="$productDir/build.${ARCH}/pharo.cog.spur" 
		pattern="*.app"
		os="mac"
		;;
	linux32x86) 
		productDir="`find $productDir/products -name "${vmVersion}*"`" 
		pattern="*"
		os="linux"
		;;
	linux64x64) 
		productDir="`find $productDir/products -name "${vmVersion}*"`" 
		pattern="*"
		os="linux"
		;;
	linux32ARMv6) 
		productDir="`find $productDir/products -name "${vmVersion}*"`" 
		pattern="*"
		ARCH="ARMv6"
		os="linux"
		;;
	*) 
		echo "Undefined platform!"
		exit 1
esac

if [ -z "${productDir}" ]; then
	echo "Error: Product not found!"
	exit 1
fi

buildId="`echo ${TRAVIS_COMMIT} | cut -b 1-7`"
zipFileName="`pwd`/../pharo-${os}-${SRC_ARCH}${HEARTBEAT}.${buildId}.zip"
pushd .
cd ${productDir}
zip -r ${zipFileName} ${pattern}
popd