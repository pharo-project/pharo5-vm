code generation
generate
	| moduleName pluginName |

	output := String new writeStream.
	moduleName := self moduleName.
	"99% of the time is the same as moduleName, but not always. 
	 Check ThreadedFFIPlugin as an example."
	pluginName := plugin moduleName. 
	
#(	vmGen config setGlobalOptions: self.
	
	self 
		printHeader;
		project: name;
		"include directories generated for build"
		include: '../directories.cmake'.
	
	self set: 'CMAKE_CONFIGURATION_TYPES' to: 'Release'.
).

	self message: (internal ifTrue: [ 'Adding internal plugin: '] ifFalse: ['Adding external plugin: '])  , moduleName.

	self 
		set: #pluginName toString: moduleName;
		set: #pluginSrc toString: '${srcPluginsDir}/', moduleName;
		set: #pluginCross toString: '${crossDir}/plugins/', moduleName;
		set: #pluginPlatform toString: '${targetPlatform}/plugins/', moduleName.

	"clear LINKLIBS variable"
	self set: #LINKLIBS to: ''.		
	
	internal 
		ifTrue: [ self puts: 'add_definitions(-DSQUEAK_BUILTIN_PLUGIN)'].
	
	self addSources: { pluginName , '.c' } prefixed: '${pluginSrc}/'.

	" default include directories for plugin "
	self includeDirectories: '${pluginSrc} ${pluginCross} ${targetPlatform}/plugins/${pluginName}'.
	
	"Not needed because there are already there (inherited from main configuration)"
	"self addDefinitions: vmGen config compilerFlags."

	" perform config's configureXYZ: message to apply per-plugin custom rules, if any "
	
	vmGen config configurePlugin: plugin with: self.
	
	extraRules ifNotNil: [ extraRules value: self ].
	
	" generate a static lib for internal plugin, or shared for external"
	internal 
		ifTrue: [ 
			self cmd: 'add_library' params:  moduleName , ' STATIC ${sources}' ] 
		ifFalse: [
			self cmd: 'add_library' params: moduleName , ' SHARED ${sources}'.
			"self cmd: 'set_property' params: 'TARGET ' , name , ' PROPERTY LINK_FLAGS -bundle'" ].

	vmGen config extraPluginSettings: self.
	
	self isExternal ifTrue: [
		self cmd: 'target_link_libraries'
			params: moduleName, ' ${LINKLIBS}' ].
	
	" see senders of #linkFlags "
	self 
		cmd: 'set_property' 
		params: 'TARGET ', moduleName, ' PROPERTY LINK_FLAGS "${linkFlags}"'.
	
	"set dependencies"
	self puts: 'IF (', moduleName , '_dependencies)'.
	
	self 
		cmd: 'add_dependencies'
		params: moduleName , ' ${', moduleName , '_dependencies}'.
	
	self puts: 'ENDIF (', moduleName , '_dependencies)'.
	
	self saveFile.