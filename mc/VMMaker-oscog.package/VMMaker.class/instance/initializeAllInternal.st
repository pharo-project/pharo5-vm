initialize
initializeAllInternal
	"add all the plugins to the internal list and make sure the external list is empty"

	self initializeInternal: self availablePlugins  external: #()