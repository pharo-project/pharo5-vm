generating actions
build
	| libssh2Include libssh2Libs libssh2 |
	libssh2 := CMThirdpartyLibrary named: 'libssh2' config: vmGen config.
	libssh2Include := '${thirdpartyDir}/', libssh2 canonicalName, '/', libssh2 unpackedDirName, '/include'.
	libssh2Libs := '${externalModulesDir}/', libssh2 libraryFileName.
	
	gen 
		puts:
'
add_custom_command(OUTPUT "${libGit2Installed}"
	COMMAND cmake -DCMAKE_INSTALL_PREFIX="${installPrefix}" -DUSE_SSH=ON -DBUILD_CLAR=OFF -DLIBSSH2_FOUND=ON -DLIBSSH2_INCLUDE_DIR="', libssh2Include, '" -DLIBSSH2_LIBRARIES="', libssh2Libs, '" ', self configurationFlags, ' . 
	WORKING_DIRECTORY "${libSourcesDir}"
	DEPENDS "${unpackTarget}" "${externalModulesDir}/', libssh2 libraryFileName, '"
	COMMAND make
	COMMAND make install
	WORKING_DIRECTORY "${libSourcesDir}"
	COMMENT "Building ${libName}"
)'

	"This custom command is needed if libgit2 is being build before libssh2 and make
	is looking for a rule to make libssh2."
,'
add_custom_command(OUTPUT "${unpackTarget}" "${externalModulesDir}/', libssh2 libraryFileName, '"
	COMMAND cd "${thirdpartyDir}/libssh2" && make libssh2Include
)
'
