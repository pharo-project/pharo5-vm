Used to build 32 bit Cog on Debian 64 bits.

You need to prepare Debian this way:

apt-get install ia32-libs libc6-dev-i386 gcc-multilib g++-multilib

ln -s /usr/lib32/libSM.so.6 /usr/lib32/libSM.so
ln -s /usr/lib32/libICE.so.6 /usr/lib32/libICE.so
ln -s /usr/lib32/libGL.so.1 /usr/lib32/libGL.so
ln -s /usr/lib32/libX11.so.6 /usr/lib32/libX11.so

Then you can go on CogOnDebian64Config generateWithSources.

