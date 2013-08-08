bytecode generators
genReturnTopFromMethod
	self ssTop popToReg: ReceiverResultReg.
	self ssPop: 1.
	^self genUpArrowReturn