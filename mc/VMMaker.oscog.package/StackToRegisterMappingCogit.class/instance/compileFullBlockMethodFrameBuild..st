compile abstract instructions
compileFullBlockMethodFrameBuild: numCopied
	<option: #SistaV1BytecodeSet>
	| blockStart |
	<var: 'blockStart' type: #CogBlockStart>
	needsFrame ifFalse:
		[self cCode: [] inSmalltalk: [blockStart := CogBlockStart new].
		 blockStart
			startpc: initialPC;
			numArgs: methodOrBlockNumArgs;
			numCopied: numCopied;
			numInitialNils: 0.
		 self compileBlockFramelessEntry: blockStart.
		 ^self].
	super compileFullBlockMethodFrameBuild: numCopied.
	self initSimStackForFramefulMethod: initialPC