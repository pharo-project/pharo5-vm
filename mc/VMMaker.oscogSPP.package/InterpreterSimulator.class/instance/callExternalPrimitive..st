plugin support
callExternalPrimitive: mapIndex
	| entry |
	entry := (mappedPluginEntries at: mapIndex).
	^(entry at: 1) perform: (entry at: 2).