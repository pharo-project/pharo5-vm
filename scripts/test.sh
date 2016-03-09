#!/bin/bash 
set -ex

# TEST VM LOCATION ============================================================
if [ "$TRAVIS_OS_NAME" = "linux" ]; then
	VM_NAME="pharo"
elif [ "$TRAVIS_OS_NAME" = "osx" ]]; then
	VM_NAME="Pharo"
else
    echo "Unsupported OS";
    exit 1;
fi
PHARO_TEST_VM=`find results -name $VM_NAME`;

if [ -z "$PHARO_TEST_VM" ]; then
	echo "Could not find test VM in $VM_DIR";
	echo "Build the VM with scripts/build.sh"
	exit 1
fi

# ENSURE SOURCES FILE =========================================================
cp image/pharo-vm/*.sources $VM_DIR


# RUN TEST IMAGE ==============================================================
if [ "$TRAVIS_OS_NAME" == "linux" ]; then
	HEADLESS="--nodisplay"
else
	HEADLESS="--headless"
fi
"$PHARO_TEST_VM" $HEADLESS image/Pharo.image test --no-xterm ".*"
