plugin lists
internalModuleNames
	"return the list of all the internal plugins' moduleNames"
	^Array streamContents:[:strm| self internalPluginsDo:[:pl| strm nextPut: pl moduleName ]]