UI access
makeAllModulesExternal
	self initializeAllPlugins.
	self internal: #() external: self availablePlugins.
	self changed: #reinitialize 