bytecode generators
genReturnNilFromBlock
	self assert: inBlock.
	self flag: 'currently caller pushes result'.
	self annotate: (self MoveCw: objectMemory nilObject R: ReceiverResultReg)
		objRef: objectMemory nilObject.
	^self genBlockReturn