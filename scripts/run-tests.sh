#! /bin/bash 

set -ex

if [ "$SRC_ARCH" = "x86_64" ]; then
	echo "Skipping tests for 64bits (TEMPORAL)."
	exit
fi

if [ "$ARCH" = "linux32ARMv6" ]; then
	echo "Skipping tests for ARMv6 (It would be too long)."
	exit
fi

if [ "$HEARTBEAT" = "threaded" ]; then
	echo "Skipping tests for threaded (It requires a special linux configuration)."
	exit
fi

# UNZIP packed VM
VM_ARCHIVE=`ls pharo-*.zip`
VM_DIR="results"
unzip $VM_ARCHIVE -d $VM_DIR

# TEST VM LOCATION ============================================================
if [[ "$TRAVIS" = "true" && "$TRAVIS_OS_NAME" = "linux" ]]; then
	VM_NAME="pharo"
elif [[ "$TRAVIS" = "true" && "$TRAVIS_OS_NAME" = "osx" ]]; then
	VM_NAME="Pharo"
elif [ "$APPVEYOR" = "True" ]; then
	VM_NAME="PharoConsole.exe"
else
    echo "Unsupported OS";
    exit 1;
fi

PHARO_TEST_VM=`find $VM_DIR -name $VM_NAME`
if [ -z "$PHARO_TEST_VM" ]; then
	echo "Could not find test VM in $VM_DIR"
	exit 1
fi

# DOWNLOAD TEST IMAGE =========================================================
TEST_IMAGE_DIR=test-image
TEST_IMAGE="vm-test-image-50.zip"
wget --quiet http://files.pharo.org/vm/src/$TEST_IMAGE
unzip -d $TEST_IMAGE_DIR $TEST_IMAGE

# ENSURE SOURCES FILE (IN VM DIR) =============================================
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
"$PHARO_TEST_VM" $HEADLESS $TEST_IMAGE_DIR/Pharo.image test --no-xterm --fail-on-failure "$NO_TEST[A-Z].*"
