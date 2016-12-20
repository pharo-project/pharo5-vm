#!/usr/bin/env bash

set -ex

# This are defined elsewhere (usually in travis):
# 
# ARCH		- macos32x86, linux64x64, win32x86, etc.
# SRC_ARCH	- i386, x64_86
# HEARTBEAT	- threaded, itimer (or none)

vmVersion="5.0"
productDir="../opensmalltalk-vm"
productArch=$SRC_ARCH
productHeartbeat=${HEARTBEAT}
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
		os="linux"
		productArch="ARMv6"
		;;
	win32x86) 
		productDir="$productDir/build.${ARCH}/pharo.cog.spur/build/vm" 
		pattern="Pharo.exe PharoConsole.exe *.dll"
		os="win"
		;;
	win64x64) 
		productDir="$productDir/build.${ARCH}/pharo.cog.spur/build/vm" 
		pattern="Pharo.exe PharoConsole.exe *.dll"
		os="win"
		;;
	*) 
		echo "Undefined platform!"
		exit 1
esac

if [ -z "${productDir}" ]; then
	echo "Error: Product not found!"
	exit 1
fi

# revision date
buildDate="`grep -m1 "SvnRawRevisionString" ../opensmalltalk-vm/platforms/Cross/vm/sqSCCSVersion.h | sed 's/[^0-9.]*\([0-9.]*\).*/\1/'`"
if [ -z "${buildDate}" ]; then 
	buildDate="NODATE"
fi
# revision id
if [[ "${APPVEYOR}" ]]; then
	commitSHA="${APPVEYOR_REPO_COMMIT}"
else
	commitSHA="${TRAVIS_COMMIT}"
fi
buildId="`echo ${commitSHA} | cut -b 1-7`"
if [ -z "${buildId}" ]; then 
	buildId="NOSHA" 
fi
# zip
zipFileName="`pwd`/../pharo-${os}-${productArch}${productHeartbeat}-${buildDate}-${buildId}.zip"

pushd .
cd ${productDir}
zip -y -r ${zipFileName} ${pattern}
popd