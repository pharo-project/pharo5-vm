source directories
crossPlatformPluginsDirectory
	"return the directory where we should find the cross-platform plugin specific sources"

	(self crossPlatformDirectory directoryExists: self class pluginsDirName)
		ifFalse: ["The supposed directory for the plugins code does not 
					exist. We need to raise a suitable exception, but cant 
					think of one right now."
					^self couldNotFindPlatformDirectoryFor: 'any plugins needing cross-platform'].
	^self crossPlatformDirectory directoryNamed: self class pluginsDirName