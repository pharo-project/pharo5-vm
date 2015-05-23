generating actions
build

	gen 
		puts:
'
include(ExternalProject)
ExternalProject_Add(
	libgit2_external #target name (new target, not the same as libgit2)
	URL ${url} #automatically downloads extracts and verifies
	URL_MD5 ${md5sum}
	DOWNLOAD_DIR ${workDir}
	INSTALL_DIR ${libGit2Installed}
	PREFIX ${workDir} #base directory
	SOURCE_DIR ${libSourcesDir}
	#arguments to the external cmake command
	CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${installPrefix}
		-DUSE_SSH=ON
		-DBUILD_CLAR=OFF
		-DLIBSSH2_FOUND=ON
		-DLIBSSH2_INCLUDE_DIR=${installPrefix}/include
		-DCMAKE_C_FLAGS=''-m32'' -DCMAKE_CXX_FLAGS=''-m32''
		#on Unix/Solaris systems $ORIGIN refers to the path of the executable
		#"-Wl,<option>" is a flag for gcc to pas the arguments through to the linker
		-DCMAKE_SHARED_LINKER_FLAGS=-Wl,-rpath=''\$ORIGIN:\$ORIGIN/Plugins''
)

#make sure libssh2 is build before libgit2
add_dependencies(libgit2_external libssh2)
'
