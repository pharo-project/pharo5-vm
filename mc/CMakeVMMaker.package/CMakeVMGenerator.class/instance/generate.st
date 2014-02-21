code generation
generate
	| intPlugins extPlugins |
			
	output := String new writeStream.
	
	config setGlobalOptions: self.
	
	self 
		printHeader;
		project: config executableName.

	config setGlobalOptionsAfterDetermineSystem: self.

	config setupDirectories: self.
	
	self message: '${CMAKE_MODULE_PATH}'.
	self set: 'CMAKE_CONFIGURATION_TYPES' to: 'Release'.

	config preferredIncludes 
		do: [ :each | self includeDirectories: each ].
	self includeDirectories: self includeDirs.	
	config standardIncludes 
		do: [:each | self includeDirectories: each ].

	self addDefinitions: config compilerFlags.

	config extraVMSettings: self.
	
	self puts: 'add_executable(' , config executableName, ' ', config executableType, ' ' , self sources , ')'.
	
	intPlugins := self generatePluginConfigs: config internalPlugins internal: true.
	extPlugins := self generatePluginConfigs: config externalPlugins internal: false.

	self processThirdpartyLibraries.
	
	self processPlugins:  intPlugins, extPlugins.

	config setExtraTargetProperties: self.
	
	self cmd: 'target_link_libraries'
		params: self moduleName , ' ${LINKLIBS}'.

	config postBuildActions: self.
	
	self saveFile.
	self generateBuildScript.