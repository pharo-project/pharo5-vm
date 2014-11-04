gmake commands
generate

	| name |
	output := String new writeStream.

	name := plugin moduleName.
	self printHeader.
	
	self addDefinitions: '-DSQUEAK_BUILTIN_PLUGIN'.
	
	self addSources: { name , '.c' } prefixed: '$(TOP_PATH)/src/plugins/', name,'/'.

	self includeDirectories: '$(TOP_PATH)/src/'.
	self includeDirectories: '$(TOP_PATH)/platforms/Cross/plugins/', name, '/'.
	self includeDirectories: '$(TOP_PATH)/platforms/unix/plugins/', name, '/'.
	
	
	vmGen config compilerFlags do:[:each | self addDefinitions: each].

	" perform config's configureXYZ: message to apply per-plugin custom rules, if any "
	
	vmGen config configurePlugin: plugin with: self.
	extraRules ifNotNil: [ extraRules value: self ].
	
	vmGen config extraPluginSettings: self.
	
	self saveFile.