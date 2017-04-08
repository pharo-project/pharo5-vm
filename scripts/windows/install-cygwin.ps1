. $PSScriptRoot\config.ps1

function Start-FileDownload($Url, $FileName)
{
    Invoke-WebRequest -Uri $Url -OutFile $FileName
}

function Install-Packages($List)
{
    # https://cygwin.com/faq/faq.html#faq.setup.cli
    # Command Line Options:
    # -d --no-desktop                   Disable creation of desktop shortcut
    # -g --upgrade-also                 also upgrade installed packages
    # -n --no-shortcuts                 Disable creation of desktop and start menu shortcuts
    # -q --quiet-mode                   Unattended setup mode
    # -N --no-startmenu                 Disable creation of start menu shortcut
    # -O --only-site                    Ignore all sites except for -s
    # -B --no-admin                     Do not check for and enforce running as Administrator
    
    # -R --root                         Root installation directory
    # -s --site                         Download site
    # -l --local-package-dir            Local package directory
    # -P --packages                     Specify packages to install

    Start-Process -Wait -FilePath .\$CYG_SETUP -ArgumentList "-dgnqNO -R $CYG_ROOT -s $CYG_MIRROR -l $CYG_ROOT\var\cache\setup -P $List"
}

if (!(Test-Path $CYG_SETUP)) {
    Start-FileDownload "https://cygwin.com/setup-x86.exe" -FileName $CYG_SETUP
}

# Presumably pre-install packages for appveyor
Install-Packages autoconf,automake,bison,gcc-core,gcc-g++,mingw-runtime,mingw-binutils,mingw-gcc-core,mingw-gcc-g++,mingw-pthreads,mingw-w32api,libtool,make,python,gettext-devel,gettext,intltool,libiconv,pkg-config,git,wget,curl
# From pharo-vm's appveyor list
Install-Packages mingw64-$MINGW_ARCH-gcc-core,mingw64-$MINGW_ARCH-gcc-g++,mingw64-$MINGW_ARCH-headers,mingw64-$MINGW_ARCH-runtime,zip,mingw64-$MINGW_ARCH-clang,libiconv-devel,libglib2.0-devel,perl,mingw64-$MINGW_ARCH-zlib,cmake,mingw64-$MINGW_ARCH-win-iconv
# zip != unzip; we need both
Install-Packages wget,unzip