#!/usr/bin/env bash

set -ex

default_arch="i386"
ARCH=$default_arch

# ARGUMENT HANDLING ===========================================================
print_usage() {
	echo "Usage: $0 [-a i386|x86_64]"
	echo ""
	echo " -a 	Architecture to build. Default is i386"
	echo ""
	echo "This script builds the sources for the VM for the currently running platform."
}

while getopts "ha:" option; do 
	case "$option" in
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

# FIND BUILDER =================================================
case "$ARCH" in
	i386) BUILDER="PharoVMSpur32Builder" ;;
	x86_64) BUILDER="PharoVMSpur64Builder" ;;
	*) 
		echo "Invalid architecture: $ARCH"
		exit 1
		;;
esac

# FIND THIS SCRIPT's LOCATION =================================================
SCRIPT_DIR=`readlink "$0"` || SCRIPT_DIR="$0";
SCRIPT_DIR=`dirname "$SCRIPT_DIR"`;
cd "$SCRIPT_DIR"
SCRIPT_DIR=`pwd -P`

# DETECT SYSTEM PROPERTIES ====================================================
TMP_OS=`uname | tr "[:upper:]" "[:lower:]"`
if [[ "{$TMP_OS}" = *darwin* ]]; then
    OS="mac";
elif [[ "{$TMP_OS}" = *linux* ]]; then
    OS="linux";
elif [[ "{$TMP_OS}" = *win* ]]; then
    OS="win";
elif [[ "{$TMP_OS}" = *mingw* ]]; then
    OS="win";
else
    echo "Unsupported OS";
    exit 1;
fi

# =============================================================================
cd "$SCRIPT_DIR/../image"
./newImage.sh
./pharo generator.image eval "$BUILDER buildOnJenkins: '$OS'."