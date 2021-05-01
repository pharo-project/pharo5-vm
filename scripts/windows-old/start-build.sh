#!/usr/bin/env bash

################################################################################
# written by Max Leske
# 2015-07-20
#
# This script takes as single argument the path the build process
# should run in
################################################################################

# convert windows path to POSIX
# '\' -> '/', ':' -> '', '//' -> '/'
# the last replacement is just to allow for POSIX paths as arguments too
build_dir="$(echo /${1} | sed -e 's/\\/\//g' -e 's/://' -e 's/\/\//\//g')"
pharovm_dir="${build_dir}/pharo-vm"

# functions
###############

function checkForGit() {
  echo "Checking if Git is installed..."
  which git > /dev/null 2>&1
  if [ ! ${?} -eq 0 ]; then
    echo ""
    echo "$PATH"
    echo ""
    echo "Could not find Git. It is currently nearly impossible to install Git on Windows machines without user interaction. Please install either"
    echo "  msysgit: http://msysgit.github.io"
    echo "  or the official Git: http://git-scm.com/download/win."
    echo "Once you've done that, rerun this script."
    sleep 60
    exit 1
  else
    echo "Found Git. Proceeding..."
  fi
}

function checkForCMake() {
  echo "Checking if CMake is installed..."
  cmake_dir=$(ls ${build_dir} | grep cmake | grep -v zip)
  which cmake > /dev/null 2>&1
  if [ ${?} -eq 0 ]; then
    echo "Found CMake. Proceeding..."
  elif [ -d "${build_dir}/${cmake_dir}/bin" ]; then
    export PATH="${PATH}:${build_dir}/${cmake_dir}/bin"
    echo "Found CMake. Proceeding..."
  else
    echo "Could not find CMake. Downloading and installing..."
    wget -O cmake.zip http://www.cmake.org/files/v3.3/cmake-3.3.0-win32-x86.zip
    unzip cmake.zip
    cmake_dir=$(ls ${build_dir} | grep cmake | grep -v zip)
    export PATH="${PATH}:${build_dir}/${cmake_dir}/bin"
    echo "Installed CMake. Proceeding..."
  fi
}

function fixHeadersAndLibs() {
  echo "Fixing headers and libraries..."
  mingw_dir=$(which mingw-get)
  mingw_dir="${mingw_dir%*/bin/*}"

  # copy fixed float.h
  float_path=$(find "${mingw_dir}/lib/gcc/" -regex ".*/include/float.h")
  cp "${pharovm_dir}/platforms/win32/extras/float.h" ${float_path%*/}

  # add missing defs to _mingw.h
  echo "#define off64_t _off64_t" >> "${mingw_dir}/include/_mingw.h"
  echo "#define off_t _off_t" >> "${mingw_dir}/include/_mingw.h"
  # this was apparently necessary once, however, my builds work fine without
  # this step.
  # echo "#define off64_t _off64_t" >> "${mingw_dir}/mingw32/include/_mingw.h"
  # echo "#define off_t _off_t" >> "${mingw_dir}/mingw32/include/_mingw.h"

  # copy libcrtdll (obsolete but needed)
  cp "${pharovm_dir}/platforms/win32/extras/libcrtdll.a" "${mingw_dir}/lib"
}


# main program
################

cd "${build_dir}"
checkForGit
checkForCMake
fixHeadersAndLibs
echo "Running build script..."
"${build_dir}/pharo-vm/scripts/build.sh" > "${build_dir}/build.log"
