generate sources
generateInternalPlugins
	"generate the internal plugins and add their exports to the main list. te exports list is NOT written to file by this method"

	self deleteUnwantedInternalPluginDirectories.
	InterpreterPlugin initialize.
	self internalPluginsDo: [:plugin | 
		self privateGenerateInternalPlugin: plugin].
	self logDateAndTime.
	self storeInternalPluginList.