plugin lists
externalModuleNames
	"return the list of all the external plugins' moduleNames"
	^Array streamContents:[:strm| self externalPluginsDo:[:pl| strm nextPut: pl moduleName ]]