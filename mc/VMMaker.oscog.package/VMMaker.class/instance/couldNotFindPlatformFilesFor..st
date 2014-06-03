private - errors
couldNotFindPlatformFilesFor: plugin
	"This should raise a nice exception to a UI"
	(VMMakerException new messageText: self class name, ' could not find platform specific files for: ', plugin moduleName) signal