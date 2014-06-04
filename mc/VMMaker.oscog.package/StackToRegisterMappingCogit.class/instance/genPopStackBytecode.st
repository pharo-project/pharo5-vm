bytecode generators
genPopStackBytecode
	self annotateBytecodeIfAnnotated: self ssTop.
	self ssTop spilled ifTrue:
		[self AddCq: BytesPerWord R: SPReg].
	self ssPop: 1.
	^0