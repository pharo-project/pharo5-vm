code generation
generate

	"override this method to produce gmake syntax"
	
	| intPlugins extPlugins |
	output := String new writeStream.
		
	self printHeader.
	
	config setupDirectories: self.
	
	self project: 'pharoVM'.
	
	self setTargetPlatform: config architecture.
	
	config preferredIncludes 
		do: [ :each | self includeDirectories: each ].

	config standardIncludes 
		do: [:each | self includeDirectories: each ].
	
	config compilerFlags do:[:each | 
		self addDefinitions: each].
	
	config linkFlags do: [:each |  
		self addExternalLibrary: each.].
	
	config coreSources do: [:each | 
		self addCoreSource: each.
		].
	
	config crossSources do: [:each | 
		self addCrossSource: each.
		].
	
	
	config platformSources do:[:each | 
		self addPlatformSource: each platform: config platformName.
		].
	
	config extraVMSettings: self.
	
	intPlugins := self generatePluginConfigs: config internalPlugins internal: true.
	extPlugins := self generatePluginConfigs: config externalPlugins internal: false.

	self processThirdpartyLibraries.
	
	self processPlugins:  intPlugins.
	
	
	"self append: #LOCAL_SRC_FILES with: self sources.
		
	self processInternalPlugins.	
	config setExtraTargetProperties: self."
	
	self includeAsSharedLib.
	
	
	config addVMDrivers: self. 
	
	
	
	self saveFile.
