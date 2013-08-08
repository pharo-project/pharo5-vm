initialize
initializeAllInternalBut: arrayOfExternalPluginNames
	"add all the plugins to the internal list except for those listed, which should be added to the external list"

	self initializeInternal: (self availablePlugins copyWithoutAll: arrayOfExternalPluginNames) external:  arrayOfExternalPluginNames