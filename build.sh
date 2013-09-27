# ARGUMENT HANDLING =============================================================
if { [ "$1" = "-h" ] || [ "$1" = "--help" ]; }; then
	echo "This script builds the VM for the currently running platform.
"
	exit 0;
elif [ $# -gt 0 ]; then
	echo "--help is the only argument allowed"
	exit 1;
fi

# DETECT SYSTEM PROPERTIES ======================================================
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

# ===============================================================================
codegen-scripts/extract-commit-info.sh
cd image
./newImage.sh
echo "PharoVMBuilder buildOnJenkins: '$OS'." > ./script.st
./pharo generator.image script.st
cd ../build/build.sh