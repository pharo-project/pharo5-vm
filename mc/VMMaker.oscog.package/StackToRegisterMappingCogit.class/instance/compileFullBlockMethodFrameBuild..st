compile abstract instructions
compileFullBlockMethodFrameBuild: numCopied
	<option: #SistaV1BytecodeSet>
	needsFrame ifFalse:
		[self initSimStackForFramelessMethod: initialPC.
		 ^self].
	super compileFullBlockMethodFrameBuild: numCopied.
	self initSimStackForFramefulMethod: initialPC