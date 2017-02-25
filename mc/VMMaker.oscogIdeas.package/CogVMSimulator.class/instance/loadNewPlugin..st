plugin support
loadNewPlugin: pluginString
	(breakSelector notNil
	 and: [(self str: pluginString n: breakSelector cmp: pluginString size) = 0]) ifTrue:
		[self halt: pluginString].
	^(self tryLoadNewPlugin: pluginString pluginEntries: mappedPluginEntries) ifNotNil:
		[:entry|
		 pluginList := pluginList copyWith: entry.
		 entry]