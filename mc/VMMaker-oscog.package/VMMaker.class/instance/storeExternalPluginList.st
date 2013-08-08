exports
storeExternalPluginList
	| contents filePath fileStream |
	contents := String streamContents:
		[:s|
		s nextPutAll:'# Automatically generated makefile include for external plugins'.
		s cr; nextPutAll:'EXTERNAL_PLUGINS ='.
		self externalPluginsDo:
			[:cls|
			s space; nextPut: $\; cr; nextPutAll: cls moduleName].
		s cr].
	filePath := self makefileDirectory / self externalPluginListName.
	(CCodeGenerator basicNew needToGenerateHeader: filePath file: filePath contents: contents) ifTrue:
		[[fileStream := VMMaker forceNewFileNamed: filePath] 
			on: FileDoesNotExistException 
			do:[^self couldNotOpenFile: filePath].
		 fileStream nextPutAll: contents; close]