generating actions
build
	| libssh2Include libssh2 |
	libssh2 := CMThirdpartyLibrary named: 'libssh2' config: vmGen config.
	libssh2Include := '${thirdpartyDir}/', libssh2 canonicalName, '/', libssh2 unpackedDirName, '/include'.
	
	gen 
		puts:
'
SET(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
add_custom_command(OUTPUT "${libGit2Installed}"
	COMMAND cmake -DCMAKE_INSTALL_PREFIX="${installPrefix}" -DUSE_SSH=ON -DBUILD_CLAR=OFF -DLIBSSH2_FOUND=ON -DLIBSSH2_INCLUDE_DIR="', libssh2Include, '" -DLIBSSH2_LIBRARIES="', libssh2 targetForLinking, '" ', self configurationFlags, ' . 
	WORKING_DIRECTORY "${libSourcesDir}"
	DEPENDS "${unpackTarget}" ''', libssh2 targetForLinking, '"
	COMMAND make
	COMMAND make install
	WORKING_DIRECTORY "${libSourcesDir}"
	COMMENT "Building ${libName}"
)'

	"This custom command is needed if libgit2 is being build before libssh2 and make
	is looking for a rule to make libssh2."
,'
add_custom_command(OUTPUT "', libssh2 targetForLinking, '"
	COMMAND cd "${thirdpartyDir}/libssh2" && make ', libssh2 buildTarget, '
)
'
