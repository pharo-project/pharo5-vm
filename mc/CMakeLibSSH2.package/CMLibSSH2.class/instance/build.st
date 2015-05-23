generating actions
build

	gen 
		puts:
'
include(ExternalProject)
ExternalProject_Add(
        libssh2
        URL "${url}"
        URL_MD5 "${md5sum}"
        DOWNLOAD_DIR "${workDir}"
        INSTALL_DIR ${libSSH2Installed}
        PREFIX "${workDir}"
        BUILD_IN_SOURCE 1
        SOURCE_DIR "${libSourcesDir}"
        TMP_DIR "${workDir}"
        BUILD_COMMAND make
        CONFIGURE_COMMAND ./configure --prefix=${installPrefix} CFLAGS=''-m32'' LDFLAGS=''-m32''
)
'