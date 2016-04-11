compile abstract instructions
compileFullBlockMethodFrameBuild: numCopied
	needsFrame ifFalse:
		[self initSimStackForFramelessMethod: initialPC.
		 ^self].
	super compileFullBlockMethodFrameBuild: numCopied.
	self initSimStackForFramefulMethod: initialPC