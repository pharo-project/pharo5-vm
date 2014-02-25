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
---------
Building the VM under windows requires a more complex setup which is described in the separate [win32 readme](README-Win32.md) file.


Building the VM
================

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

##Building for iOS

The process for compiling the VM for iOS is almost the same, but there are some extra steps you need to do:

1. You need to produce a valid Pharo image (which is a plain Pharo image with some packages). The easiest way to do it is going to `iosbuild/resources`, then execute:
	```
	./generate.sh
	```

2. The lines you need to evaluate in `generator.image` for producing iOS sources are:
	```
	PharoIPhoneBuilder buildIPhone.
	PharoIPhoneBuilder buildIPhoneSimulator.
	```
	(the differences between them are self explanatory)

3. You can then execute `sh build.sh` in build subdirectory, and you will have a Pharo.app waiting for you in `results` :) 
	
That will not solve certain common problems you will find when working for iOS, thought. I will try to cover some of them now.

####Problem 1: Debugging/deploying through Xcode 
You will need to produce a valid xcodeproj file. Is very easy, just follow next steps. 

1. Go to `build` directory
2. execute: `../scripts/extract-commit-info.sh`
3. remove CMakeCache.txt (if it exists)
4. execute: `cmake -G Xcode .`

Done! you will have an xcode project and you can proceed from there as any other regular iOS app.

####Problem 2: Signing for publishing
The problem of publishing apps is very complicated and in my opinion, moronic... but well, that's the game and we have to play with those rules (I will not explain them, in part because I do not understand it completely, you can go to [Apple developers site](http://developer.apple.com) and try to dig it there).  
There is one tool that you can use to automate the signing process, assuming you have all the required previous steps:  
```
xcrun -sdk iphoneos PackageApplication \
    /path/to/your/results/Pharo.app \
    -o "/path/to/your/results/iPharo.ipa" \
    --sign "iPhone Distribution: YOUR DISTRUBUTION NAME" \
    --embed "/pat/to/your/app.mobileprovision"
```

Acknowledge
===========
The Pharo VM is a flavour of the Cog VM, a new and fast VM for Pharo, Squeak and Newspeak. It implements context-to-stack mapping, JIT (just in time compiler), PIC (polymorphic inline caching), Multi-threading, etc.  

For more data about the Cog VM, please visit [the offical Cog website](http://www.mirandabanda.org/cog/)
