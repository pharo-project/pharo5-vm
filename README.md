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


Building the VM
================

1. Download the sources from [github](https://github.com/pharo-project/pharovm)
 ```bash
 git clone --depth=1 https://github.com/pharo-project/pharo-vm.git
 cd pharo-vm
 ```

2. Get a fresh pharo image from the build server by running the script in the `image` folder.
 ```bash
 cd image && ./newImage.sh
 ```

3. `generator.image` now contains VMMaker with the Slang sources, plus a workspace with some
example VM configurations.
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


4. Once the sources are exported, you can launch cmake and build the VM:
```bash
cd build
./build.sh
```

5. Finally, run the freshly compiled VM from `results`.

See a complete guide on how to build Cog VM using cmake on:
http://code.google.com/p/cog/wiki/Guide
