exports
storeInternalPluginList
	| contents filePath fileStream |
	((self internalPluginListName beginsWith: 'example')
	 and: [self makefileDirectory fileExists: self internalPluginListName]) ifTrue:
		[^self].
	contents := String streamContents:
		[:s|
		s nextPutAll:'# Automatically generated makefile include for internal plugins'.
		s cr; nextPutAll:'INTERNAL_PLUGINS ='.
		self internalPluginsDo:
			[:cls|
			s space; nextPut: $\; cr; nextPutAll: cls moduleName].
		s cr].
	filePath := self makefileDirectory fullNameFor: self internalPluginListName.
	(CCodeGenerator basicNew needToGenerateHeader: filePath file: filePath contents: contents) ifTrue:
		[[fileStream := VMMaker forceNewFileNamed: filePath] 
			on: FileDoesNotExistException 
			do:[^self couldNotOpenFile: filePath].
		 fileStream nextPutAll: contents; close]