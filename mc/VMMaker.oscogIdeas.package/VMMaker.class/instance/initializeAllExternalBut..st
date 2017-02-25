initialize
initializeAllExternalBut: arrayOfInternalPluginNames
	"add all the plugins to the external list except for those listed, which should be added to the internal list"

	self initializeInternal: arrayOfInternalPluginNames external: (self availablePlugins copyWithoutAll: arrayOfInternalPluginNames )