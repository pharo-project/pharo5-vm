NOTE
====

This is the VM as up to Pharo-4.0. Pharo-5.0 and beyond is currently located in
the [spur64](https://github.com/estebanlm/pharo-vm/tree/spur64) branch of
esteban.



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
To build the VM you need: git, cmake, wget, gnu-tar, the latest version of Xcode, and the MacOSX 10.6 SDK.

One way of downloading and installing these is to use the [homebrew](http://brew.sh/) package manager:
```bash
# install homebrew with the following oneliner:
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
# if you haven't installed git yet
brew install git
# if you haven't installed cmake yet
brew install cmake
# wget is needed in certain cases to download files
brew install wget
# OSX' default tar doesn't feature 7z compression needed for for some 3rd party libs
#Follow the instruction of `brew info gnu-tar` to make this `tar` version the system default
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
--------
Building the VM under windows requires a more complex setup which is described in the separate [win32 readme](README-Win32.md) file.

iOS:
----
Building the VM under iOS requires a more complex setup which is described in the separate [iOS readme](README-iOS.md) file.


Building the VM
================
(For Windows build, see below)

1. Download the sources from [github](https://github.com/pharo-project/pharo-vm)
 ```bash
 git clone --depth=1 https://github.com/pharo-project/pharo-vm.git
 cd pharo-vm
 ```
 Note the windows specific steps mentioned in the [win32 readme](README-Win32.md).

2. Get a fresh pharo image from the build server by running the script in the `image` folder.
 ```bash
 cd image && ./newImage.sh
 ```

3. `generator.image` now contains VMMaker with the Slang sources, plus a workspace with some
example VM configurations. In case there is no workspace, open one and paste the line you need.
Pick or edit the configuration you want, then evaluate it (Do It).
 ```Smalltalk
 "Unix"
 PharoVMBuilder buildUnix32.
 "OSX"
 PharoVMBuilder buildMacOSX32.
 "Windows"
 PharoVMBuilder buildWin32.
 ```
See `startup.st` for more examples for the common platforms.

As an alternative, try (Windows flavor shown):

```
./pharo generator.image eval 'PharoVMBuilder buildWin32'
```

Should you want to build a StackVM version, use the PharoSVMBuilder.

4. Once the sources are exported, you can launch cmake and build the VM:
```bash
cd ../build
bash build.sh
```

Before doing that, you would be well advised to make a tar or zipfile of the whole folder in case you encounter a compilation/resources download problem as doing the whole process above is quite long.

5. Finally, run the freshly compiled VM from `results`.

Building the VM from an IDE
===========================
If you want to build the virtual machine from an IDE, you could ask cmake to generate the IDE project for you.
At step 4, instead of calling ```build.sh```, you can run:
```bash
cd ../build
if [ ! -e vmVersionInfo.h ]; then
        ../scripts/extract-commit-info.sh
fi
cmake . -G Xcode
```
It will generate a project for Xcode. Other options are available like Visual Studio.
Then open the project from your IDE and compile from there.

Acknowledge
===========
The Pharo VM is a flavour of the Cog VM, a new and fast VM for Pharo, Squeak and Newspeak. It implements context-to-stack mapping, JIT (just in time compiler), PIC (polymorphic inline caching), Multi-threading, etc.  

For more data about the Cog VM, please visit [the offical Cog website](http://www.mirandabanda.org/cog/)
