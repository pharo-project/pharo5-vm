compile abstract instructions
compileFullBlockMethodFrameBuild: numCopied
	<option: #SistaV1BytecodeSet>
	needsFrame ifFalse:
		[self assert: numCopied = 0.
		 self compileFullBlockFramelessEntry: numCopied.
		 self initSimStackForFramelessBlock: initialPC.
		 ^self].
	super compileFullBlockMethodFrameBuild: numCopied.
	self initSimStackForFramefulMethod: initialPC