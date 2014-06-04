plugin primitive support
dispatchMappedPluginEntry: n 
	^(mappedPluginEntries at: n) first
		perform: (mappedPluginEntries at: n) second