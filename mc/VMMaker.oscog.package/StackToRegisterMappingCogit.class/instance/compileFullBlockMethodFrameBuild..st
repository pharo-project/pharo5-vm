compile abstract instructions
compileFullBlockMethodFrameBuild: numCopied
	<option: #SistaV1BytecodeSet>
	needsFrame ifFalse:
		[ self assert: methodOrBlockNumArgs = 0. "Else calling convention would have put args in regs while block activation expects them on stack"
		 self initSimStackForFramelessMethod: initialPC.
		 ^self].
	super compileFullBlockMethodFrameBuild: numCopied.
	self initSimStackForFramefulMethod: initialPC