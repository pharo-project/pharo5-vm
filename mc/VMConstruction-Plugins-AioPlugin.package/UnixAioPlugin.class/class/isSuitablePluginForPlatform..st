translation
isSuitablePluginForPlatform: platformName
	"Answer true is this is an instance of the class which is responsible for
	representing the OS process for the Squeak VM running on platform.
	Newer versions of VMMaker use this mechanism"

	^ platformName = 'unix'
		or: [platformName = 'Mac OS']