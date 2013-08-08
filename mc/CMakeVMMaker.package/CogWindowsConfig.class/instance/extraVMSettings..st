settings
extraVMSettings: maker

	| res |
	
	res := '"${buildDir}/resource.o"'.
	
	self write: self resourceFile toFile: 'Cog.rc'.
		
	maker cmd: 'add_custom_command' params: 'OUTPUT ', res ,
	'
		COMMAND 	windres --include-dir ${targetPlatform}/misc -D_WIN32 -i ${buildDir}/Cog.rc -o ', res , '
		COMMENT "Generating resource file..."
	'.
	
	maker set:  #resources to: res.
	
	maker includeDirectories: '${targetPlatform}/third-party/dx9sdk/Include'.
	