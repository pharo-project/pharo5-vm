bytecode generators
genReturnNil
	self genMoveNilR: ReceiverResultReg.
	^self genUpArrowReturn