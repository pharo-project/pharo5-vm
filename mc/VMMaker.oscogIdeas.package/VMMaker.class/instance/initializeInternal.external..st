initialize
initializeInternal: arrayOfInternalPluginNames external: arrayOfExternalPluginNames
	"try to set up with the listed internal and external plugins."

	self initialize.

	self internal: arrayOfInternalPluginNames external: arrayOfExternalPluginNames