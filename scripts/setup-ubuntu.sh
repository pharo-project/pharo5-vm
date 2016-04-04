# ARGUMENT HANDLING =============================================================
if { [ "$1" = "-h" ] || [ "$1" = "--help" ]; }; then
	echo "Install libraries required to build the pharo VM under ubuntu.
"
	exit 0;
elif [ $# -gt 0 ]; then
	echo "--help/-h is the only argument allowed"
	exit 1;
fi

# INSTALL BUILD LIBRARIES ======================================================
sudo apt-get install cmake zip bash-completion ruby git xz-utils debhelper devscripts
sudo apt-get install libc6-dev:i386 libasound2:i386 libasound2-dev:i386 libasound2-plugins:i386 libssl-dev:i386 libssl0.9.8:i386 libfreetype6-dev:i386 libx11-dev:i386 libsm-dev:i386 libice-dev:i386
sudo apt-get install build-essential gcc-multilib g++ libxext-dev
# due to https://bugs.launchpad.net/ubuntu/+source/mesa/+bug/949606 we cannot directly install libgl1-mesa-dev:i386
sudo apt-get install libgl1-mesa-dev libgl1-mesa-glx:i386 mesa-common-dev
sudo ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so /usr/lib/i386-linux-gnu/libGL.so
sudo ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 /usr/lib/i386-linux-gnu/mesa/libGL.so

