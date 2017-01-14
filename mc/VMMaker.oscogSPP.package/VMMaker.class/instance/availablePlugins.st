UI access
availablePlugins
	allPlugins ifNil:[self initializeAllPlugins].
	^allPlugins