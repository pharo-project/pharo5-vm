UI access
listOfName: aSymbol
	"work out which list is the one associated with this symbol"
	#availableModules = aSymbol ifTrue:[^allPlugins].
	#internalModules = aSymbol ifTrue:[^internalPlugins].
	#externalModules =aSymbol ifTrue:[^externalPlugins].
	^nil