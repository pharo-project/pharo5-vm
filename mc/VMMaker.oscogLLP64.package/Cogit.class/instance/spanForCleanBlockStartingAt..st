compile abstract instructions
spanForCleanBlockStartingAt: startPC
	<var: #descriptor type: #'BytecodeDescriptor *'>
	| pc end descriptor |
	pc := startPC.
	end := objectMemory numBytesOf: methodObj.
	[pc <= end] whileTrue:
		[descriptor := self generatorAt: (objectMemory fetchByte: pc ofObject: methodObj) + bytecodeSetOffset.
		 pc := pc + descriptor numBytes.
		 descriptor isReturn ifTrue:
			[^pc - startPC]].
	self error: 'couldn''t locate end of clean block'.
	^0