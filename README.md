REQUIREMENTS
============

The build relies on a valid gcc, cmake and 32 bit headers installation:

Unix:
-----
```bash    
# build tools
sudo apt-get install gcc g++ cmake lib32x-dev
# dependencies for vm plugins
sudo apt-get install libasound2-dev libssl-dev libfreetype6-dev libgl1-mesa-dev
```

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

Download and install the latest version of XCode and XCode command line tools.
Download [MacOSX10.6.sdk.zip](http://files.pharo.org/vm/src/lib/MacOSX10.6.sdk.zip) and put it in
`/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs` (just where MacOSX10.x.sdk usually are)
(YES, WE NEED 10.6 SDK!) 
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
Install git: <http://code.google.com/p/msysgit/>

Optional: add git to the PATH variable so that you can see git from msys. To do this, add path to git for msys: Control panel -> System, then search for Environment Variables. There should be already: C:\Program Files\Git\cmd. Add C:\Program Files\Git\bin. Notice that the path may not be exactly `C:\Program Files\Git` but similar…
Make sure that path to Git binary directory is **after** msys bin path, otherwise you will get a lot of troubles.

Install [CMake](http://www.cmake.org/): during installation, in install options , make sure that you choose to [add CMake to `PATH`](http://www.google.com/search?q=windows+add+PATH&btnI).

To check if everything is installed, open MSYS program (which should look like a UNIX terminal) and try to execute the different commands: git, make and cmake.

Also there are some discrepancy with recent GCC (4.6.1), you need to add:
```C
	#ifndef _MINGW_FLOAT_H_
		#include_next <float.h>
	#endif
```
into `C:\MinGW\lib\gcc\mingw32\4.6.1\include\float.h` at the end of that file.
The version number, in this case 4.6.1, might be different in your case.


BUILDING FROM JENKINS SOURCES
=============================

If you downloaded the complete sources from the hudson(or jenkins) server use cmake
to build the VM.
```bash
cd build
cmake .
make
```
**DO NOT USE** scripts in `unixbuild` or `macbuild` or `cygwinbuild` to build VMs.
There is no any guarantees that they are working for sources taken from git repositories!


(RE)CREATING THE GENERATED VM SOURCES
=====================================

If you downloaded the sources from gitorious do the following the VM sources
are not included (unlike the jenkins build download). The following steps
explain how to generate the VM sources from a build image.

1. Get a fresh pharo image from the build server by running the script in
the image folder.
```bash
cd image && ./newImage.sh
```

2. This image contains VMMaker and slang sources, plus a workspace with some
example VM configurations.
Pick or edit the configuration you want, then evaluate it.
```Smalltalk
	CogCocoaIOSConfig generateWithSources.
```
See the `startup.st` for more examples for the common platforms.


3. Once the sources are exported, you can launch cmake and build the VM:

    - UNIX:
```bash
# using Unix Makefiles
cd build
sh ../codegen-scripts/extract-commit-info.sh
cmake .             # this is the same as cmake -G "Unix Makefiles"
make
```

    - OSX:

```bash
export MACOSX_DEPLOYMENT_TARGET=10.6
sh ../codegen-scripts/extract-commit-info.sh
cd build
cmake .
make
```
    - Varia: consult the last section from `cmake --help` to check for other
    generators. For instance, to create an XCode project under OSX, do the following:
```bash
cd build
sh ../codegen-scripts/extract-commit-info.sh
# remove existing cache to avoid issues
rm -f CMakeCache.txt
# make sure we don't use llvm
export CC='gcc-4.2';
cmake -G "Xcode"
open CogVM.xcodeproj
```

4. Finally, run the freshly compiled VM from `results`.


See a complete guide on how to build Cog VM using cmake on:
http://code.google.com/p/cog/wiki/Guide

