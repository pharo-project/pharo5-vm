UI access
makeAllModulesInternal
	self initializeAllPlugins.
	self internal: self availablePlugins external: #().
	self changed: #reinitialize 