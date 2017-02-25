private - errors
couldNotFindPluginClass: pluginSymbol
	"This should raise a nice exception to a UI"
	(VMMakerException new messageText: self class name, ' could not find the class for: ', pluginSymbol) signal