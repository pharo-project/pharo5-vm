UI access
reinitializePluginsLists
	"something has changed that affects the validity of the plugin lists. Recalculate them as best we can. It is probably possible to check on the current lists and keep the configuration as close as possible the same; but for the moment just try to use the same lists "
	self initializeAllPlugins.
	self internal: internalPlugins external: externalPlugins.
	self changed: #reinitialize 