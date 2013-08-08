as yet unclassified
saveFile
	
	| reference |
	reference := ((vmGen config dirFrom: vmGen buildDir) / plugin moduleName) ensureDirectory; yourself.
	(FileStream forceNewFileNamed: (reference / self outputFileName) fullName)
		nextPutAll: (self config fixLineEndsOf: output contents);
		close.