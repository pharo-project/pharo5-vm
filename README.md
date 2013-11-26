Build Status
============
- Master Branch: [![Build Status](https://travis-ci.org/pharo-project/pharo-vm.png?branch=master)](https://travis-ci.org/pharo-project/pharo-vm)
- Develop Branch: [![Build Status](https://travis-ci.org/pharo-project/pharo-vm.png?branch=develop)](https://travis-ci.org/pharo-project/pharo-vm)

REQUIREMENTS
============

The build relies on a valid gcc, cmake and 32 bit headers installation:

Unix:
-----
see [setup-ubuntu.sh](scripts/setup-ubuntu.sh) for a complete setup for a recent ubuntu machine.

Mac:
-----
Download and install the [homebrew](http://brew.sh/) package manager with some additional packages
```bash
# install homebrew with the following oneliner:
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
# if you haven't installed git yet
brew install git
# wget is needed in certain cases to download files
brew install wget
# OSX' default tar doesn't feature 7z compression needed for for some 3rd party libs
brew install gnu-tar --default-names
```

Install the latest version of [XCode](https://itunes.apple.com/en/app/xcode/id4977998350) and XCode command line tools.
Download [MacOSX10.6.sdk.zip](http://files.pharo.org/vm/src/lib/MacOSX10.6.sdk.zip) and put in [Xcode SDK folder](file:///Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs):
```bash	  
# make sure you're root: sudo su
cd /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs
wget http://files.pharo.org/vm/src/lib/MacOSX10.6.sdk.zip
unzip MacOSX10.6.sdk.zip
rm MacOSX10.6.sdk.zip
```

Windows:
---------
For building the VM under windows you will have to install a [minggw environment](http://sourceforge.net/projects/mingw/files/Automated%20MinGW%20Installer/mingw-get-inst/).

Install the following additional MinGW packages by running the following command in the MingGW Shell:
```bash
mingw-get install msys-unzip msys-wget msys-zip
```
Install git: <http://code.google.com/p/msysgit/> and [add it to `PATH` variable](http://www.google.com/search?q=windows+add+PATH&btnI) after the `msys` paths.

Install [CMake](http://www.cmake.org/): during installation, in install options , make sure that you choose to [add CMake to `PATH`](http://www.google.com/search?q=windows+add+PATH&btnI).

To check if everything is installed, open MSYS program (which should look like a UNIX terminal) and try to execute the different commands: `git`, `make` and `cmake`.

Also there are some discrepancy with recent GCC (4.6.1), you need to add:
```C
#ifndef _MINGW_FLOAT_H_
#include_next <float.h>
#endif
```
into `C:\MinGW\lib\gcc\mingw32\4.6.1\include\float.h` at the end of that file.
The version number, in this case 4.6.1, might be different in your case.

At the time of writing the mingw32 version is 4.8.1.

There are additional steps to take to have the build process to work on a 64 bit Windows machine (e.g. Windows 8.1 Pro): 

1. As the build process uses libcrtdll.dll, one needs to make a libcrtdll.a to link against. libcrtdll.dll is obsolete but that's what we do use. So, one must have a libcrtdll.def file from which to create the libcrtdll.a file. A copy of those files is provided in the wind32support directory. Copy the libcrtdll.a file in C:\MinGW\lib

2. The _mingw.h header has to be amended to deal with changes in some typedefs. One needs to add:

```
#define off64_t _off64_t
#define off_t _off_t
```
at the end.

For some weird reason, make sure you copy the _mingw.h header to the:

C:\MinGW\include
C:\MinGW\mingw32\include

folders.

Should you need a copy of crtdll32.dll, it lives in C:\Windows\SysWOW64 on 4-bit system. The build process fails to find it on such machines.

3. time_t in its 32-bit version is required by the VM at this point in time. To work properly and avoid the "time_t structure is not 32 bit" error message, the CMakeLists.txt file in the build folder has to be changed (add  -D_USE_32BIT_TIME_T). The VMMaker CMake related package should take care of this. Not done yet.

``` 
add_definitions(-march=pentium4 -mwindows -D_MT -msse2 -mthreads -mwin32 -mno-rtd -mms-bitfields -mno-accumulate-outgoing-args -D_WIN32_WINNT=0x0501 -DWINVER=0x0501 -DWIN32 -DWIN32_FILE_SUPPORT -DNO_ISNAN -DNO_SERVICE -DNO_STD_FILE_SUPPORT -DLSB_FIRST -DVM_NAME="Pharo" -D_USE_32BIT_TIME_T -DX86 -DSTACK_ALIGN_BYTES=16 -DALLOCA_LIES_SO_USE_GETSP=0 -DENABLE_FAST_BLT  -g0 -O2 -march=pentium4 -momit-leaf-frame-pointer -maccumulate-outgoing-args -funroll-loops -DNDEBUG -DDEBUGVM=0)
```


Building the VM
================

1. Download the sources from [github](https://github.com/pharo-project/pharo-vm)
 ```bash
 git clone --depth=1 https://github.com/pharo-project/pharo-vm.git
 cd pharo-vm
 ```

2. Get a fresh pharo image from the build server by running the script in the `image` folder.
 ```bash
 cd image && ./newImage.sh
 ```

3. `generator.image` now contains VMMaker with the Slang sources, plus a workspace with some
example VM configurations. (That's not true as there will be no workspace open or your with that, so open a workspace and copy paste the line you need, and then evaluate it (Do It)).
Pick or edit the configuration you want, then evaluate it.
 ```Smalltalk
 "Unix"
 PharoVMBuilder buildUnix32.
 "OSX"
 PharoVMBuilder buildMacOSX32.
 "Windows"
 PharoVMBuilder buildWin32.
 ```
See `startup.st` for more examples for the common platforms.

Should you want to build a StackVM version, use the PharoSVMBuilder.

4. Once the sources are exported, you can launch cmake and build the VM:
```bash
cd build
./build.sh
```

Before doing that, you would be well advised to make a tar or zipfile of the whole folder in case you encounter a compilation/resources download problem as doing the whole process above is quite long.

5. Finally, run the freshly compiled VM from `results`.

See a complete guide on how to build Cog VM using cmake on:
http://code.google.com/p/cog/wiki/Guide (even if this VM is the PharoVM and notthe CogVM per se).
