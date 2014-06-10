target directories
platformPluginsDirectories

	^self platformDirectories
		select: [:dir| (dir / self class pluginsDirName) exists]
		thenCollect: [:dir| (dir / self class pluginsDirName) exists]