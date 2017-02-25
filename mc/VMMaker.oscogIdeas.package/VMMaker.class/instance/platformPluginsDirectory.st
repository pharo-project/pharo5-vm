source directories
platformPluginsDirectory
	"return the directory where we should find the platform plugin specific sources"

	(self platformDirectory directoryExists: self class pluginsDirName)
		ifFalse: ["The supposed directory for the plugins code does not 
					exist. We need to raise a suitable exception, but cant 
					think of one right now."
					^self couldNotFindPlatformDirectoryFor: 'any plugins needing ', self platformName].
	^self platformDirectory directoryNamed: self class pluginsDirName