#A fast-track on building vm on Windows 10 (64bits)
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


#Git configuration

Run all of this in an elevated command prompt (Win-X > Command Prompt (Admin) - seems that things are stored un der Program Files at some point)

This will help you some headaches with LF/CRLF mess in Windows/Linux

    git config core.text auto

In order to get rid of the GeniePlugin message about path being too long, make sure your version of Git is above 1.8.x (current version installed on 2015-09-29 is 2.5.3).

    git config --system core.longpaths true

Presto, no more long paths problems on Windows. git stash and all are usable again.


