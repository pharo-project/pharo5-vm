directories
setupDirectories: gen
	"we have to override that, because we need to convert windoze paths to msys ones"
	| dirsInclude |
	
	" write the directories in separate include file"
	dirsInclude := gen captureOutputDuring: [
		gen
			set: #topDir toString: (self msysPathFor: self topDir fullName); 
			set: #buildDir toString: (self buildDir ifNil: ['${topDir}/build'] ifNotNil:[ self msysPathFor: self buildDir fullName ]);
			set: #thirdpartyDir toString: '${buildDir}/thirdparty';
			set: #platformsDir toString: (self msysPathFor: self platformsDir);
			set: #srcDir toString: (self msysPathFor: self srcDir);
			set: #srcPluginsDir toString: (pluginsDir ifNil: [ '${srcDir}/plugins' ]);
			set: #srcVMDir toString: '${srcDir}/vm';
			set: #platformName toString: self platformName;
			set: #targetPlatform to: '${platformsDir}/${platformName}';
			set: #crossDir toString: '${platformsDir}/Cross';
			set: #platformVMDir toString: '${targetPlatform}/vm';
			set: #outputDir toString: (self msysPathFor: self outputDir).
	].

	self write: dirsInclude toFile: 'directories.cmake'.
	
	gen include: 'directories.cmake'.
	
	gen set: #externalModulesDir toString: self externalModulesDir.
