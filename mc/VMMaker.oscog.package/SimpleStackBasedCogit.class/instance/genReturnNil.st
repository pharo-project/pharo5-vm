bytecode generators
genReturnNil
	self genMoveConstant: objectMemory nilObject R: ReceiverResultReg.
	^self genUpArrowReturn