plugin support
callExternalPrimitive: mapIndex
	| entry |
	entry := mappedPluginEntries at: (mapIndex > 1000
										ifTrue: [externalPrimitiveTable at: mapIndex - 1001]
										ifFalse: [mapIndex]).
	^(entry at: 1) perform: (entry at: 2).