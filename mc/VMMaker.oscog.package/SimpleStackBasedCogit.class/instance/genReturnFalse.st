bytecode generators
genReturnFalse
	self annotate: (self MoveCw: objectMemory falseObject R: ReceiverResultReg)
		objRef: objectMemory falseObject.
	^self genUpArrowReturn