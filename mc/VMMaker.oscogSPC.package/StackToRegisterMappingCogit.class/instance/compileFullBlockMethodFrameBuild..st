compile abstract instructions
compileFullBlockMethodFrameBuild: numCopied
	<option: #SistaV1BytecodeSet>
	useTwoPaths ifTrue: 
		[ "method with only inst var store, we compile only slow path for now" 
		 useTwoPaths := false.
		 self cppIf: IMMUTABILITY ifTrue: [ needsFrame := true ] ].
	needsFrame ifFalse:
		[self assert: numCopied = 0.
		 self compileFullBlockFramelessEntry: numCopied.
		 self initSimStackForFramelessBlock: initialPC.
		 ^self].
	super compileFullBlockMethodFrameBuild: numCopied.
	self initSimStackForFramefulMethod: initialPC