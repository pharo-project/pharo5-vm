bytecode generators
genReturnNil
	self annotate: (self MoveCw: objectMemory nilObject R: ReceiverResultReg)
		objRef: objectMemory nilObject.
	^self genUpArrowReturn