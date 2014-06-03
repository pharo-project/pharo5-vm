bytecode generators
genReturnTrue
	self annotate: (self MoveCw: objectMemory trueObject R: ReceiverResultReg)
		objRef: objectMemory trueObject.
	^self genUpArrowReturn