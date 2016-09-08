#!/usr/bin/env bash
set -ex

# ARGUMENT HANDLING ===========================================================
if { [ "$1" = "-h" ] || [ "$1" = "--help" ]; }; then
	echo "This script builds the VM for the currently running platform.
"
	exit 0;
elif [ $# -gt 0 ]; then
	echo "--help is the only argument allowed"
	exit 1;
fi

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
./pharo generator.image eval "
	NonInteractiveTranscript stdout install.
	PharoVMSpur32Builder buildOnJenkins: '$OS'.
"

# =============================================================================

cd "$SCRIPT_DIR/.."
"$SCRIPT_DIR/extract-commit-info.sh"

# =============================================================================

cd "$SCRIPT_DIR/../build"
bash ./build.sh