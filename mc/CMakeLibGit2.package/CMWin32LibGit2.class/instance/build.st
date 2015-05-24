generating actions
build
	| libssh2 libssh2Libs |
	libssh2 := CMThirdpartyLibrary named: 'libssh2' config: vmGen config.
	libssh2Libs := '${installPrefix}/lib/', libssh2 libraryFileName.

	gen 
		puts:
'
include(ExternalProject)
ExternalProject_Add(
        libgit2 #target name
        URL ${url} #automatically downloads extracts and verifies
        URL_MD5 ${md5sum}
        DOWNLOAD_DIR ${workDir}
        INSTALL_DIR ${installPrefix}
        PREFIX ${workDir} #base directory
        SOURCE_DIR ${libSourcesDir}
        #arguments to the external cmake command
        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${installPrefix}
		-DUSE_SSH=ON
		-DBUILD_CLAR=OFF
		-DLIBSSH2_FOUND=ON
		-DLIBSSH2_INCLUDE_DIR=${installPrefix}/include
		#libgit2 uses package config to search for the library (which won''t find ours).
		#we need to pass this so that libgit2 explicitly depends on libssh2,
		#otherwise the link will be missing in the library.
		-DLIBSSH2_LIBRARIES=', libssh2Libs, '
		-G "MSYS Makefiles''
		-DCMAKE_C_FLAGS=''-m32''
		-DCMAKE_CXX_FLAGS=''-m32''.
)

ExternalProject_Add_Step(libgit2 copy_libgit2_artefacts_to_results
	COMMAND cp ${libGit2Installed} ${externalModulesDir}/${libraryFileName}
	DEPENDEES install
)

#make sure libssh2 is built before libgit2
add_dependencies(libgit2 libssh2)
'
