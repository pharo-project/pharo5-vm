plugin lists
allModuleNames
	"return the list of all the all plugins' moduleNames"
	^Array streamContents:[:strm| self allPluginsDo:[:pl| strm nextPut: pl moduleName ]]