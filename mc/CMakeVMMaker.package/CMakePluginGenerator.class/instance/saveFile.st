accessing
saveFile
	
	| reference |
	reference := ((vmGen config dirFrom: vmGen buildDir) / self moduleName) ensureCreateDirectory; yourself.
	(FileStream forceNewFileNamed: (reference / self outputFileName) fullName)
		nextPutAll: (self config fixLineEndsOf: output contents);
		close.