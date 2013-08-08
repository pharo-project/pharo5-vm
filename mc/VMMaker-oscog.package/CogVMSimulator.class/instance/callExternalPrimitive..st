plugin support
callExternalPrimitive: mapIndex
	| entry |
	entry := self pluginEntryFor: mapIndex.
	^(entry at: 1) perform: (entry at: 2)