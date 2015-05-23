generating actions
build

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
                -DCMAKE_C_FLAGS=''-m32'' -DCMAKE_CXX_FLAGS=''-m32''
                #on Unix/Solaris systems $ORIGIN refers to the path of the executable
                #"-Wl,<option>" is a flag for gcc to pas the arguments through to the linker
                -DCMAKE_SHARED_LINKER_FLAGS=-Wl,-rpath=''\$ORIGIN:\$ORIGIN/Plugins''
)

ExternalProject_Add_Step(libgit2 fix_libgit2_links
        COMMAND cd ${installPrefix}/lib && ln -s ${libraryFileName}.22.0 ${libraryFileName}
        DEPENDEES install
)

ExternalProject_Add_Step(libgit2 copy_libgit2_artefacts_to_results
        COMMAND cp ${libGit2Installed} ${externalModulesDir}/${libraryFileName}
        DEPENDEES fix_lib_links
)

#make sure libssh2 is built before libgit2
add_dependencies(libgit2 libssh2)
'
