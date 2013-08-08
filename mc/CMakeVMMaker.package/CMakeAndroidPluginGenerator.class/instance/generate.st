gmake commands
generate

	| name |
	output := String new writeStream.

	name := plugin moduleName.
	self printHeader.
	
	self 
		set: #pluginName to: name;
		set: #pluginSrc to: '$(srcPluginsDir)/', name;
		set: #pluginCross to: '$(crossDir)/plugins/', name;
		set: #pluginPlatform to: '$(targetPlatform)/plugins/', name.
		
	self addDefinitions: '-DSQUEAK_BUILTIN_PLUGIN'.
	
	self addSources: { name , '.c' } prefixed: '$(pluginSrc)/'.

	self includeDirectories: '-I$(pluginSrc) -I$(pluginCross) -I$(targetPlatform)/plugins/$(pluginName)'.

	self addDefinitions: vmGen config compilerFlags.

	" perform config's configureXYZ: message to apply per-plugin custom rules, if any "
	
	vmGen config configurePlugin: plugin with: self.
	
	extraRules ifNotNil: [ extraRules value: self ].
	
	vmGen config extraPluginSettings: self.
	
	self saveFile.