Pharo VM 
============
[![Download](https://api.bintray.com/packages/pharo-project/pharo-vm/build/images/download.svg) ](https://bintray.com/pharo-project/pharo-vm/build/_latestVersion#files) [![Build Status](https://travis-ci.org/pharo-project/pharo-vm.png)](https://travis-ci.org/pharo-project/pharo-vm) [![Windows Build status](https://ci.appveyor.com/api/projects/status/v8tkyye60e67wq5c?svg=true)](https://ci.appveyor.com/project/estebanlm/pharo-vm-0xuf7)

Development fork(s)
-------------------

- [estebanlm](https://github.com/estebanlm/pharo-vm) [![Build Status](https://travis-ci.org/estebanlm/pharo-vm.png)](https://travis-ci.org/estebanlm/pharo-vm) [![Windows Build status](https://ci.appveyor.com/api/projects/status/kskw07q17nphv5qy?svg=true)](https://ci.appveyor.com/project/estebanlm/pharo-vm)

REQUIREMENTS
============
The build relies on a valid gcc, cmake and 32 bit headers installation:

- [Linux](README-Linux.md)
- [OSX](README-OSX.md)
- [Win32](README-Win32.md)

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
 PharoVMSpur32Builder buildUnix32.
 "OSX"
 PharoVMSpur32Builder buildMacOSX32.
 "Windows"
 PharoVMSpur32Builder buildWin32.
 ```
See `startup.st` for more examples for the common platforms.

As an alternative, try (Windows flavor shown):

```
./pharo generator.image eval 'PharoVMSpur32Builder buildWin32'
```

Should you want to build a StackVM version, use the PharoSVMSpur32Builder.

4. Once the sources are exported, you can launch cmake and build the VM:
```bash
cd ../build
bash build.sh
```

Before doing that, you would be well advised to make a tar or zipfile of the whole folder in case you encounter a compilation/resources download problem as doing the whole process above is quite long.

5. Finally, run the freshly compiled VM from `results`.

Building for iOS
----------------
Information on how to build a VM for iOS can be found [here](README-iOS.md).


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
