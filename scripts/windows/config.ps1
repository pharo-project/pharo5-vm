# Pick a mirror that is close to you https://cygwin.com/mirrors.html
# US mirror (used by appveyor)
#$CYG_MIRROR = "http://cygwin.mirror.constant.com"
$CYG_MIRROR = "http://ftp.inf.tu-dresden.de/software/windows/cygwin32/"

$FLAVOR = "pharo.cog.spur"
$CYG_ROOT = "C:\cygwin"
$CYG_SETUP = "setup-x86.exe"
$ARCH = "win32x86"
$MINGW_ARCH = "i686"
$SRC_ARCH = "i386"

$env:Path = "$CYG_ROOT\bin;$env:Path"
