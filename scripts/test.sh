#!/bin/bash 
set -ex

# TEST VM LOCATION ============================================================
VM_DIR="results"
if [ "$TRAVIS_OS_NAME" = "linux" ]; then
	VM_NAME="pharo"
elif [ "$TRAVIS_OS_NAME" = "osx" ]]; then
	VM_NAME="Pharo"
else
    echo "Unsupported OS";
    exit 1;
fi

echo "DIR: `pwd`"
PHARO_TEST_VM=`find $VM_DIR -name $VM_NAME`;
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

NO_TEST="^(?!Metacello)"			# too long
NO_TEST="$NO_TEST(?!Versionner)"	# too long
NO_TEST="$NO_TEST(?!GT)"			# too slow
NO_TEST="$NO_TEST(?!Athens)"		# no cairo, no athens
NO_TEST="$NO_TEST(?!OSWindow)"		# no cairo, no oswindow

NO_TEST="$NO_TEST(?!TxText)"		# no cairo, no TxText
NO_TEST="$NO_TEST(?!ReleaseTests)"	# just not now :)
"$PHARO_TEST_VM" $HEADLESS image/Pharo.image test --no-xterm --fail-on-failure "$NO_TEST[A-Z].*"
