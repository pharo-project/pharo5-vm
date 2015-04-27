bytecode generators
genReturnNilFromBlock
	self assert: inBlock.
	self flag: 'currently caller pushes result'.
	self genMoveConstant: objectMemory nilObject R: ReceiverResultReg.
	^self genBlockReturn