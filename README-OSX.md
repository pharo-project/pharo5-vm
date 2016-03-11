# OSX Build Setup:

To build the VM you need: git, cmake, wget, gnu-tar, the latest version of Xcode, and the MacOSX 10.6 SDK.

One way of downloading and installing these is to use the [homebrew](http://brew.sh/) package manager:
```bash
# install homebrew with the following oneliner:
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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
