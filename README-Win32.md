#Windows (32bits) Build Setup:

##Prerequisites

**NOTE: I'm updating the instructions, it will be more clear next days. [Here](README-Win32-fasttrack.md) is a fast track (the "happy path") for building VM on windows right now.**

We provide a set of scripts which automates the build process on Windows platforms. The only thing you need to have in advance is an installation of Git (as of this writing it is nearly impossible to install Git from a script without compiling it).
There are two options:

- the official [Git client for Windows](http://git-scm.com/download/win)
- [Git for Windows / msysGit](http://msysgit.github.io)

Either choice is fine, just make sure that Git is on your `PATH`. You can test if it is by [opening a (new) cmd shell](http://www.google.com/search?q=windows+open+cmd) and typing `git`. If it's on the `PATH` you'll see the help page. If Git is not yet on your `PATH` you need to [add it](http://www.google.com/search?q=windows+add+PATH).

##Advanced environment setup
*If you only want to quickly build the VM you can skip this section and continue with [Starting the build] (#starting-the-build)*

There are a couple more things we require to build the VM:

- [MinGW](...) + msys
- [CMake](http://cmake.org) **IMPORTANT: You has to install [CMake 2.8.8](http://www.cmake.org/files/v2.8/cmake-2.8.8-win32-x86.exe), this is the only version we certify that works (and we know some newer versions are not generating proper scripts). Of course, we will change this in the future :)**

The scripts will download these dependencies if they're not present but they will only be added to the temporary (process) `PATH`. If you intend to build the VM multiple times you'll achieve shorter build times by having these dependencies preinstalled and on your `PATH`.

###MinGW + msys installation
1. Download the [MinGW setup installer] (http://sourceforge.net/projects/mingw/files/Automated%20MinGW%20Installer/mingw-get-inst/) and run it. Make sure to [add the MinGW binaries to your `PATH`](http://www.google.com/search?q=windows+add+PATH).
2. Install the following additional MinGW packages by running the following command in a shell (cmd shell will work):
  ```mingw-get install msys-unzip msys-wget msys-zip```
3. Make sure that the msys paths appear on the `PATH` **before** the Windows default paths. Otherwise you will experience build failures because of name clashes (e.g. the build scripts use the GNU `find` program which clashes with the Windows `find` program)

###CMake installation
Install [CMake](http://www.cmake.org/): during installation, in install options, make sure that you choose to [add CMake to `PATH`](http://www.google.com/search?q=windows+add+PATH&btnI).


To check if everything is installed, open a shell (again, cmd will work) execute the different commands: `git`, `make` and `cmake`.


###Notes:
Should you need a copy of crtdll32.dll, it lives in C:\Windows\SysWOW64 on 64-bit system. The build process fails to find it on such machines.


If you need to find out where the msys paths are, you can add the following to your `.profile` and start an msys shell:
```
winpath() {
    if [ -z "$1" ]; then
        echo "$@"
    else
        if [ -f "$1" ]; then
            local dir=$(dirname "$1")
            local fn=$(basename "$1")
            echo "$(cd "$dir"; echo "$(pwd -W)/$fn")" | sed 's|/|\\|g';
        else
            if [ -d "$1" ]; then
                echo "$(cd "$1"; pwd -W)" | sed 's|/|\\|g';
            else
                echo "$1" | sed 's|^/\(.\)/|\1:\\|g; s|/|\\|g';
            fi
        fi
    fi
}
```


##Starting the build
**Note:**
While the setup script is actually part of this repository, we recommend that you follow the steps below and don't clone the repository yourself (see [Documentation of script operations](#documentation-of-script-operations)).

1. [Download the build setup script](scripts/windows/setup.cmd)
2. Either double click on the script (the shell window will close immediately after the build) or launch the script from a shell. In either case output will be logged to `<currentDirectory>/vm-build/build-setup.log` and `<currentDirectory>/vm-build/build.log` (which you can `tail` if you want).
3. Wait for the build to finish
4. The built objects reside in `<currentDirectory>/vm-build/pharo-vm/results`



Documentation of script operations
====================================

##General
1. create a build directory
2. download MinGW and msys, add them to `PATH` and install packages
3. download CMake and add it to `PATH`
4. clone pharo-vm repository (see below)
5. fix build environment (see below)
6. run the actual build script

##Modify repository configuration before checkout
1. clone the repository with the `--no-checkout` option
2. set the `text` configuration option to `auto`: `git config --add core.text auto`
3. `git checkout -f HEAD`

##Modify float.h
For GCC 4.6.1+ float.h (`<mingw_directory>/lib/gcc/<version>/include/float.h`) add this to the end of the file:
```
#ifndef _MINGW_FLOAT_H_
#include_next <float.h>
#endif
```

## Add 32-bit dependencies
For 64-bit machines (e.g. Windows 8.1 Pro) we need to add `libcrtdll.dll` (which is obsolete on those platforms).

1. `cp <pharovmDirectory>/platforms/win32/extras/libcrtdll.a <mingwDirectory>/lib`
2. The _mingw.h header has to be amended to deal with changes in some typedefs. Add the following to the end of _mingw.h:

```
#define off64_t _off64_t
#define off_t _off_t
```

## Configure Git for long paths
In order to get rid of the GeniePlugin message about path being too long, make sure your version of Git is above 1.8.x (current version installed on 2015-09-29 is 2.5.3).

```
git config core.text auto
git config --system core.longpaths true
```
