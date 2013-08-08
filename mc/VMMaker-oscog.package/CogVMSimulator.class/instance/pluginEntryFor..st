plugin support
pluginEntryFor: mapIndex
	^mappedPluginEntries at: (mapIndex > 1000
								ifTrue: [externalPrimitiveTable at: mapIndex - 1001]
								ifFalse: [mapIndex])