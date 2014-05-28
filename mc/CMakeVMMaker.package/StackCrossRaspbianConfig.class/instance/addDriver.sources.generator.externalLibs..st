as yet unclassified
addDriver: name sources: aSources generator: cmakeGen externalLibs: extLibs

	| cfg srcs |
	
	srcs := aSources inject: '' into: [:res :each | res , ' "', each, '"' ].
	cfg := cmakeGen
		captureOutputDuring: [
			cmakeGen printHeader;
			project: name;
			include: '../directories.cmake';
		
			message: 'Adding module: ', name;
			
			addDefinitions:  self compilerFlags;
			addDefinitions: '-fPIC -DPIC';
			set: #sources to: srcs;
			
			cmd: 'add_library' params: name, ' SHARED ${sources}'; 
	 		includeDirectories: '${CMAKE_FIND_ROOT_PATH}/usr/include';
			includeDirectories: '${crossDir}/plugins/FilePlugin';
			includeDirectories: '${targetPlatform}/plugins/B3DAcceleratorPlugin';
			includeDirectories: '${crossDir}/plugins/B3DAcceleratorPlugin';
			set: 'LIBRARY_OUTPUT_PATH' toString: self outputDir fullName;
			linkDirectories: '${CMAKE_FIND_ROOT_PATH}/usr/lib/arm-linux-gnueabihf/';
		
			addExternalLibraries: extLibs;
			
			cmd: 'target_link_libraries' params: name , ' ${LINKLIBS}';
			cmd: 'set_target_properties' params: name , ' PROPERTIES PREFIX "" SUFFIX "" ' 
	].
	
	(self buildDir / name) ensureCreateDirectory.
	self write: cfg toFile: name , '/', cmakeGen outputFileName.
	cmakeGen addSubdirectory:  name.
	