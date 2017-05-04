#! /bin/bash

# uploads VMs as "nightly-build". 
# latest builds are in fact built with in opensmaltalk CI, using
# ../opensmalltalk-vm/deploy/pharo/deploy-files.pharo.org

set -ex

get_os() {
	local file=$1
	if [[ "{$file}" = *mac* ]]; then
    	echo "mac";
	elif [[ "{$file}" = *linux* ]]; then
    	echo "linux";
	elif [[ "{$file}" = *win* ]]; then
    	echo "win";
	else
    	echo "Unsupported OS";
    	exit 1;
	fi
}

get_arch() {
	local file=$1
	if [[ "{$file}" = *x86_64* ]]; then
    	echo "x86_64";
	elif [[ "{$file}" = *i386* ]]; then
    	echo "i386";
	elif [[ "{$file}" = *ARMv6* ]]; then
    	echo "ARMv6";
	else
    	echo "Unsupported architecture";
    	exit 1;
	fi
}

get_heartbeat() {
	local file=$1
	if [[ "{$file}" = *threaded* ]]; then
    	echo "threaded";
	elif [[ "{$file}" = *itimer* ]]; then
    	echo "i386";
	else
    	echo "Unsupported heartbeat";
    	exit 1;
	fi
}

destDir="/appli/files.pharo.org/vm/nightly-build"
productName=$(ls ./pharo-*.zip)
if [ -z "$productName" ]; then 
	echo "Product not found in `pwd`. Aborting deploy."
	exit 1
fi 
os=$(get_os "$productName")
arch=$(get_arch "$productName")
heartbeat=$(get_heartbeat "$productName")

echo "Uploading $productName to pharo.files.org/$destDir"
scp $productName files.pharo.org:$destDir/$productName
scp $productName files.pharo.org:$destDir/pharo-$os-$arch$heartbeat-latest.zip