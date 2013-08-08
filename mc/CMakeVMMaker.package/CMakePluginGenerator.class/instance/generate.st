code generation
generate

	| name |
	output := String new writeStream.

	name := plugin moduleName.
#(	vmGen config setGlobalOptions: self.
	
	self 
		printHeader;
		project: name;
		"include directories generated for build"
		include: '../directories.cmake'.
	
	self set: 'CMAKE_CONFIGURATION_TYPES' to: 'Release'.
).

	self message: (internal ifTrue: [ 'Adding internal plugin: '] ifFalse: ['Adding external plugin: '])  , name.

	self 
		set: #pluginName toString: name;
		set: #pluginSrc toString: '${srcPluginsDir}/', name;
		set: #pluginCross toString: '${crossDir}/plugins/', name;
		set: #pluginPlatform toString: '${targetPlatform}/plugins/', name.

	"clear LINKLIBS variable"
	self set: #LINKLIBS to: ''.		
	
	internal 
		ifTrue: [ self puts: 'add_definitions(-DSQUEAK_BUILTIN_PLUGIN)'].
	
	self addSources: { name , '.c' } prefixed: '${pluginSrc}/'.

	" default include directories for plugin "
	self includeDirectories: '${pluginSrc} ${pluginCross} ${targetPlatform}/plugins/${pluginName}'.
	
	"Not needed because there are already there (inherited from main configuration)"
	"self addDefinitions: vmGen config compilerFlags."

	" perform config's configureXYZ: message to apply per-plugin custom rules, if any "
	
	vmGen config configurePlugin: plugin with: self.
	
	extraRules ifNotNil: [ extraRules value: self ].
	
	" generate a static lib for internal plugin, or shared for external"
	internal ifTrue: [
		self cmd: 'add_library' params:  name , ' STATIC ${sources}'.
	] ifFalse: [
		self cmd: 'add_library' params: name , ' SHARED ${sources}'.
		
	"	self cmd: 'set_property' params: 'TARGET ' , name , ' PROPERTY LINK_FLAGS -bundle'"
	].

	vmGen config extraPluginSettings: self.
	
	self isExternal ifTrue: [
		self cmd: 'target_link_libraries'
			params: self moduleName , ' ${LINKLIBS}'.
		].
	
	" see senders of #linkFlags "
	self 
		cmd: 'set_property' 
		params: 'TARGET ', name, ' PROPERTY LINK_FLAGS "${linkFlags}"'.
	
	"set dependencies"
	self puts: 'IF (',self moduleName , '_dependencies)'.
	
	self cmd: 'add_dependencies'
		params: name , ' ${', self moduleName , '_dependencies}'.
	
	self puts: 'ENDIF (',self moduleName , '_dependencies)'.
	self saveFile.