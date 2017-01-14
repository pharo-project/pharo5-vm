simulation stack
ssPushAnnotatedConstant: literal
	self ssPush: 1.
	self updateSimSpillBase.
	self ssTop
		type: SSConstant;
		spilled: false;
		constant: literal;
		bcptr: bytecodePC.
	self annotateInstructionForBytecode.
	^0