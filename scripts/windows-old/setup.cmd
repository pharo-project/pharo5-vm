::##############################################################################
:: written by Max Leske
:: 2015-07-20
::##############################################################################
@ECHO off
setlocal enabledelayedexpansion

:: if this script is being run from the cloned repository we need to do
:: things a little different
set scriptDirectory=%~dp0

cd | findstr /C:"pharo-vm" > nul
if %errorlevel% equ 0 (
  call:cdToBuildDirectory
  set buildDirectory=cd
) else (
  :: create build directory
  set buildDirectory=%cd%\vm-build
  echo !buildDirectory!
  if not exist !buildDirectory! mkdir vm-build
  cd !buildDirectory!
)
set pharoDirectory=%buildDirectory%\pharo-vm
set log=%buildDirectory%\build-setup.log

:: clone repository, set windows specific configuration and checkout
if not exist %pharoDirectory% (
  git clone --depth=1 --no-checkout https://github.com/pharo-project/pharo-vm.git
  cd pharo-vm
  git config --add core.text auto
  git checkout -f HEAD
  cd %buildDirectory%
)

:: setup build environment (no bash yet)
echo Setting up build environment...
cscript.exe /Nologo %pharoDirectory%\scripts\windows\init-environment.js %buildDirectory%

:: PATH may have been modified. If so, update it
:: only set the path in the process environment, not globally
if exist %buildDirectory%\newpath (
  for /f "tokens=*" %%i IN (%buildDirectory%\newpath) DO set PATH=%%i
  del %buildDirectory%\newpath
)

:: do the rest in bash
echo Starting build...
bash.exe %pharoDirectory%\scripts\windows\start-build.sh %buildDirectory% > %log% 2>&1
echo Done.

:: cd back to original directory
cd %scriptDirectory%
goto :eof

:: functions
:cdToBuildDirectory
  rem if pharo-vm is on the path, cd to its parent directory
  cd | findstr /C:"pharo-vm" > nul
  if %errorlevel% equ 0 (
    cd ..
    goto :cdToBuildDirectory
  )
