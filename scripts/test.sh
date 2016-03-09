#!/bin/bash 
set -ex

echo "DIR: `pwd`"

# VM PROPERTIES ===============================================================
VM_TYPE="pharo"
VM_BINARY_NAME="Pharo"
VM_BINARY_NAME_LINUX="pharo"
VM_DIR="results"


# TEST VM LOCATION ============================================================
TMP_OS=`uname | tr "[:upper:]" "[:lower:]"`
if [[ "{$TMP_OS}" = *darwin* ]]; then
    PHARO_TEST_VM=`find "$VM_DIR" -name ${VM_BINARY_NAME}`;
elif [[ "{$TMP_OS}" = *linux* ]]; then
    PHARO_TEST_VM=`find "$VM_DIR" -name ${VM_BINARY_NAME_LINUX}`;
elif [[ "{$TMP_OS}" = *win* ]]; then
    PHARO_TEST_VM=`find "$VM_DIR" -name ${VM_BINARY_NAME}.exe`;
elif [[ "{$TMP_OS}" = *mingw* ]]; then
    PHARO_TEST_VM=`find "$VM_DIR" -name ${VM_BINARY_NAME}.exe`;
else
    echo "Unsupported OS";
    exit 1;
fi

if [ -z "$PHARO_TEST_VM" ]; then
	echo "Could not find test VM in $VM_DIR";
	echo "Build the VM with scripts/build.sh"
	exit 1
fi


# ENSURE SOURCES FILE =========================================================
cp image/pharo-vm/*.sources $VM_DIR


# RUN TEST IMAGE ==============================================================
if [ "$OS" == "linux" ]; then
	HEADLESS="--nodisplay"
else
	HEADLESS="--headless"
fi

TEST_IMAGE="image/Pharo.image"
"$PHARO_TEST_VM" $HEADLESS "$TEST_IMAGE" test --no-xterm ".*"
