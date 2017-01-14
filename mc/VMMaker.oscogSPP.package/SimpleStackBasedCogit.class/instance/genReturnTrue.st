bytecode generators
genReturnTrue
	self genMoveTrueR: ReceiverResultReg.
	^self genUpArrowReturn