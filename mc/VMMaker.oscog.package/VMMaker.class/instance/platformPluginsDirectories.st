target directories
platformPluginsDirectories

	^self platformDirectories
		select: [:dir| dir directoryExists: self class pluginsDirName]
		thenCollect: [:dir| dir directoryNamed: self class pluginsDirName]