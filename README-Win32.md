# Windows (32bits) Build Setup:

## Prerequisites

* git
* Windows 7 SP1 or higher
* powershell

### PowerShell

PowerShell is automatically installed in all versions of Windows 7 SP1 or higher, the only thing you will need to change execution policy. This is one-time thing if you've never used powershell before.

* Find PowerShell in the start menu, right click it and choose Run As Administrator
* Execute `Set-ExecutionPolicy RemoteSigned` and confirm `Y`
    * this will enable you to launch local powershell scripts
* Close the administrator PowerShell

## Git

We provide a set of scripts which automates the build process on Windows platforms. The only thing you need to have in advance is an installation of Git (as of this writing it is nearly impossible to install Git from a script without compiling it).
There are two options:

- the official [Git client for Windows](http://git-scm.com/download/win)
- [Git for Windows / msysGit](http://msysgit.github.io)

Either choice is fine, just make sure that Git is on your `PATH`. You can test if it is by [opening a (new) PowerShell or cmd shell](http://www.google.com/search?q=windows+open+cmd) and typing `git`. If it's on the `PATH` you'll see the help page. If Git is not yet on your `PATH` you need to [add it](http://www.google.com/search?q=windows+add+PATH).

### Long paths

Windows (by default) has path names limited to 260 or so characters, so you have to enable long paths in git.

Execute the following (in PowerShell or cmd)

`git config --system core.longpaths true`

**NOTE:** *My system requires privilege escalation for this (it's modifying system configuration), so I had to execute it from Admin PowerShell (see section #PowerShell)*


## Installing Cygwin

* Open a non-admin window of PowerShell and navigate to the _root_ of the cloned repo (`cd`/`ls` commands, just like in bash)
* Execute `.\scripts\windows\install-cygwin.ps1`
    * this will download cygwin and install/upgrade all necessary packages

## Starting The Build

**NOTE:** *Execute the scripts from the repo's root folder.*

* To perform a complete installation, execute `.\scripts\windows\builder.ps1 -All`

Or perform it step by step (typing `.\scripts\windows\builder.ps1 -<TAB>` will offer you available options)

* `.\scripts\windows\builder.ps1 -BuildSources`
* `.\scripts\windows\builder.ps1 -BuildVm`
* `.\scripts\windows\builder.ps1 -PackVm`

See also `Manual Compilation` below.

The first run of the complete build will take approximately **40 minutes**, but third party libraries are cached, so it will be much much faster next time.

### Theoretical Speedup

During compilation system's prefetcher and Windows Defender were quite busy (taking about 1GB RAM each and a whole CPU core). This could possibly slow down the build, although I have no metrics to back up this claim. In either case, you can disable Prefetcher in Windows Services, and add exception to Windows Defender the cloned repo or disable it during the build (at your own risk).

## Manual Compilation

You can also switch to cygwin's bash and run the compilation by hand as follows:

* In PowerShell (in repository's root) execute `. .\scripts\windows\config.ps1`
    * this will load necessary environment and modify PATH (for the shell only, not the system)
* Execute `bash`
* Inside bash execute `. scripts/windows/config.sh`
    * same as for PowerShell, just make sure you are sourcing file with the correct extension (`ps1` vs `sh`)
* Now you can e.g. go to `cd opensmalltalk-vm/build.win32x86/pharo.cog.spur`
* And build VM with asserts `./mvm -a`
