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
			set: #platformName toString: self platformName;
			set: #targetPlatform to: '${platformsDir}/${platformName}';
			set: #crossDir toString: '${platformsDir}/Cross';
			set: #platformVMDir toString: '${targetPlatform}/vm';
			set: #outputDir toString: '${topDir}/results'.
			gen cmd: 'link_directories' params: '${CMAKE_FIND_ROOT_PATH}/usr/lib/arm-linux-gnueabihf/'.
	].

	self write: dirsInclude toFile: 'directories.cmake'.
	
	gen include: 'directories.cmake'.
