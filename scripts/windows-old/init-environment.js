//##############################################################################
// written by Max Leske
// 2015-07-20
//
// This script takes as single argument the path the build process
// should run in
//##############################################################################

var MinGWSetupUrl = "http://freefr.dl.sourceforge.net/project/mingw/Installer/mingw-get/mingw-get-0.6.2-beta-20131004-1/mingw-get-0.6.2-mingw32-beta-20131004-1-bin.zip";
var MinGWZipFileName = "mingw-get-0.6.2-mingw32-beta-20131004-1-bin.zip";

var fsObject = WScript.CreateObject('Scripting.FileSystemObject');
var shellObject = WScript.CreateObject('WScript.Shell');
var buildDirectory = WScript.Arguments.Unnamed(0);

// list of installed packages taken from listing produced
// with mingw-get-info script from http://sourceforge.net/p/mingw/bugs/_discuss/thread/a599780b/dee6/attachment/mingw-get-info
// (see http://sourceforge.net/p/mingw/bugs/1525/)
var minGWPackageList = "mingw32-base-bin mingw32-binutils-bin mingw32-gcc-bin mingw32-gcc-dev mingw32-gcc-lic mingw32-gcc-g++-bin mingw32-gcc-g++-dev mingw32-gcc-objc-bin mingw32-gcc-objc-dev mingw32-gdb-bin mingw32-gettext-bin mingw32-gettext-dev mingw32-libexpat-dll mingw32-libgcc-dll mingw32-libgettextpo-dll mingw32-libgmp-dll mingw32-libgomp-dll mingw32-libiconv-bin mingw32-libiconv-dev mingw32-libiconv-dll mingw32-libintl-dll mingw32-libltdl-dev mingw32-libltdl-dll mingw32-libmpc-dll mingw32-libmpfr-dll mingw32-libobjc-dll mingw32-libpthread-old-dll mingw32-libpthreadgc-dll mingw32-libquadmath-dll mingw32-libssp-dll mingw32-libstdc++-dll mingw32-libtool-bin mingw32-libz-dll mingw32-make-bin mingw32-mingw-get-bin mingw32-mingw-get-gui mingw32-mingw-get-lic mingw32-mingwrt-dev mingw32-mingwrt-dll mingw32-w32api-dev";
var msysPackageList = "msys-autogen-bin msys-base-bin msys-bash-bin msys-bison-bin msys-bsdcpio-bin msys-bsdtar-bin msys-bzip2-bin msys-core-bin msys-core-doc msys-core-ext msys-core-lic msys-coreutils-bin msys-coreutils-ext msys-cvs-bin msys-diffstat-bin msys-diffutils-bin msys-dos2unix-bin msys-file-bin msys-findutils-bin msys-flex-bin msys-gawk-bin msys-grep-bin msys-guile-bin msys-gzip-bin msys-inetutils-bin msys-less-bin msys-libarchive-dll msys-libbz2-dll msys-libcrypt-dll msys-libexpat-dll msys-libgdbm-dll msys-libgmp-dll msys-libguile-dll msys-libguile-rtm msys-libiconv-dll msys-libintl-dll msys-libltdl-dll msys-liblzma-dll msys-libmagic-dll msys-libminires-dll msys-libopenssl-dll msys-libopts-dll msys-libpopt-dll msys-libregex-dll msys-libtermcap-dll msys-libxml2-dll msys-lndir-bin msys-m4-bin msys-make-bin msys-mktemp-bin msys-openssh-bin msys-openssl-bin msys-patch-bin msys-perl-bin msys-rsync-bin msys-sed-bin msys-tar-bin msys-termcap-bin msys-texinfo-bin msys-unzip-bin msys-vim-bin msys-wget-bin msys-xz-bin msys-zip-bin msys-zlib-dll";
var packageList = minGWPackageList + " " + msysPackageList;
var returnValue;

try {
  downloadAndUnzipMinGW(MinGWSetupUrl, MinGWZipFileName);
  updateProcessPath();
  // now install packages (base, shell, gcc etc.)
  installPackages();
} catch (ex) {
  WScript.Echo(ex.description);
  // keep the window open so wee can read the output
  WScript.Sleep(60000);
}
// functions
// ##############

function checkForError(value, message) {
  if(value != 0) {
    WScript.echo("An error occurred while " + message + ".");
    WScript.echo("Sleeping for 60 seconds before aborting (ctrl+c to abort immediately)...");
    WScript.Sleep(60000);
  }
}

function installPackages() {
  WScript.echo("Downloading and installing packages...");
  WScript.echo("");
  returnValue = shellObject.Run("mingw-get.exe install " + packageList, 1, true);
  checkForError(returnValue, "installing MinGW");
}

function updateProcessPath() {
  // see https://technet.microsoft.com/en-us/library/ee156595.aspx
  var processEnv = shellObject.Environment("PROCESS");
  if(processEnv("PATH").indexOf("MinGW") < 0) {
    WScript.echo("Adding 'MinGW' and 'msys' to the path");
    WScript.echo("");
    processEnv("PATH") = buildDirectory + "\\MinGW\\bin\\;" + processEnv("PATH");
    processEnv("PATH") = buildDirectory + "\\MinGW\\msys\\1.0\\bin\\;" + processEnv("PATH");
    // parent shell doesn't know about the change of PATH
    var stream = fsObject.GetFolder(buildDirectory).CreateTextFile("newpath");
    stream.WriteLine(processEnv("PATH"));
    stream.Close();
  }
  WScript.echo("The process PATH:");
  WScript.echo(processEnv("PATH"));
  WScript.echo("");
}

function downloadAndUnzipMinGW(Url, TargetFileName) {
  var MinGWPath = buildDirectory + "\\MinGW";
  if(fsObject.FolderExists(MinGWPath)) {
    return;
  }
  WScript.echo("Downloading MinGW setup...");
  WScript.echo("");
  fsObject.CreateFolder(MinGWPath);

  var Object = WScript.CreateObject('MSXML2.XMLHTTP');
  Object.Open('GET', Url, false);
  Object.Send();
  if (Object.Status != 200) {
    print("HTTP request unsuccessfull. Aborting...");
    WScript.Quit(1);
  }

  // Create the Data Stream
  var Stream = WScript.CreateObject('ADODB.Stream');
  // Establish the Stream
  Stream.Open();
  Stream.Type = 1; // adTypeBinary
  Stream.Write(Object.ResponseBody);
  Stream.Position = 0;
  if (fsObject.FileExists(TargetFileName)) {
      fsObject.DeleteFile(TargetFileName);
  }
  // Write the Data Stream to the File
  var ZipPath = buildDirectory + "\\" + TargetFileName
  Stream.SaveToFile(ZipPath, 2); // adSaveCreateOverWrite
  Stream.Close();

  var ApplicationShell = WScript.CreateObject("Shell.Application");;
  var FilesInZip = ApplicationShell.NameSpace(ZipPath).Items();
  ApplicationShell.NameSpace(MinGWPath).CopyHere(FilesInZip);
}
