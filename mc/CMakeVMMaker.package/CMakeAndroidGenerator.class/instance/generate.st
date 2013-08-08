code generation
generate

	"override this method to produce gmake syntax"
	
	output := String new writeStream.
		
	self printHeader.

	config setupDirectories: self.
		
	config preferredIncludes 
		do: [ :each | self includeDirectories: each ].
	self includeDirectories: self includeDirs.	
	config standardIncludes 
		do: [:each | self includeDirectories: each ].

	self addDefinitions: config compilerFlags.

	config extraVMSettings: self.
	
	self append: #LOCAL_SRC_FILES with: self sources.
		
	self processInternalPlugins.	
	config setExtraTargetProperties: self.
	
	self saveFile.
	