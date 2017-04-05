# A fast-track on building vm on Windows 10 (64bits)
This is a short summary of steps that works on Windows 10 64bits to build the VM.

**IMPORTANT: Versions of tools are important, when explicited.**

- install win10 64bits
- install git
- install mingw setup installer (accepting defaults)
	- basic setup:
		- mingw-developer-tools
        - mingw32-base
        - mingw32-gcc-g++
        - msys-base
    - (install with "apply changes")
- install cmake 2.8.8
- run msys.bat
- edit float.h as indicated in instructions
- git clone github.com—pharo-vm.git https://github.com/pharo-project/pharo-vm.git pharovm-trunk
- cd pharovm-trunk/image
- sh newImage.sh
- edit generator.image: in PharoVMBuilder>>#buildWin32, remove the libgit2 library (it is not working right now). Save and quit.
- ./pharo generator.image eval "PharoVMBuilder build"
- cd ../build
- sh build.sh

