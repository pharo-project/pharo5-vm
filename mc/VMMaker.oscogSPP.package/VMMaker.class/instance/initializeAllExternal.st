initialize
initializeAllExternal
	"add all the plugins to the external list and make sure the internal list is empty"

	self initializeInternal: #() external: self availablePlugins 