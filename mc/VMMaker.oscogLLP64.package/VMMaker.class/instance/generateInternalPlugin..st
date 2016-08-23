generate sources
generateInternalPlugin: pluginName 
	"generate the named internal plugin. Make sure the exports list is actually 
	correct and write it out"
	self deleteUnwantedInternalPluginDirectories.
	self privateGenerateInternalPlugin: pluginName.
	self generateExportsFile.
	self logDateAndTime