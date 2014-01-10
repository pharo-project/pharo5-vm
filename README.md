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
Building the VM under windows requires a more complex setup which is describe in the separate <README-Win32.md> file.


Building the VM
================

1. Download the sources from [github](https://github.com/pharo-project/pharo-vm)
 ```bash
 git clone --depth=1 https://github.com/pharo-project/pharo-vm.git
 cd pharo-vm
 ```
 Note the windows specifi step mentioned in <README-Win32.md>.

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

As an alternative, try (Windows flavor shown):

```
./pharo generator.image eval 'PharoVMBuilder buildWin32'
```

Should you want to build a StackVM version, use the PharoSVMBuilder.

4. Once the sources are exported, you can launch cmake and build the VM:
```bash
cd build
./build.sh
```

Before doing that, you would be well advised to make a tar or zipfile of the whole folder in case you encounter a compilation/resources download problem as doing the whole process above is quite long.

5. Finally, run the freshly compiled VM from `results`.
