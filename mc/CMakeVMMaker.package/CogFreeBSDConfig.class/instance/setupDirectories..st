as yet unclassified
setupDirectories: gen
	| dirsInclude |

	" write the directories in separate include file"
	dirsInclude := gen captureOutputDuring: [
		gen
			set: #topDir toString: '${CMAKE_SOURCE_DIR}/../'; 
			set: #buildDir toString: '${topDir}/build';
			set: #thirdpartyDir toString: '${buildDir}/thirdParty';
			set: #platformsDir toString: '${topDir}/platforms';
			set: #srcDir toString: '${topDir}/src';
			set: #srcPluginsDir toString: '${srcDir}/plugins';
			set: #srcVMDir toString: '${srcDir}/vm';
			"We need to call us 'freebsd' to get the right thirdpaty
			library name for libssh2 but the source directory only
			knows about unix. It would be a lot easier if the CMakeLists
			would be maintained in git and would have a simple conditional
			instead of subclasses and bogus selectors."
			set: #platformName toString: 'unix';
			set: #targetPlatform to: '${platformsDir}/${platformName}';
			set: #crossDir toString: '${platformsDir}/Cross';
			set: #platformVMDir toString: '${targetPlatform}/vm';
			set: #outputDir toString: '${topDir}/results'.
	].

	self write: dirsInclude toFile: 'directories.cmake'.
	
	gen include: 'directories.cmake'.

	gen set: #externalModulesDir toString: self externalModulesDir.