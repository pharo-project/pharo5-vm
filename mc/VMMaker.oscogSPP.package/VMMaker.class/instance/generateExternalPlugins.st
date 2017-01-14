generate sources
generateExternalPlugins
	"generate the external plugins"

	self logDateAndTime.
	self deleteUnwantedExternalPluginDirectories.
	InterpreterPlugin initialize.
	self externalPluginsDo: [:plugin | 
		self generateExternalPlugin: plugin].
	self storeExternalPluginList.
	self logDateAndTime