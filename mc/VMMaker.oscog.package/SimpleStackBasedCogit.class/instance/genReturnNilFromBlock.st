bytecode generators
genReturnNilFromBlock
	self assert: inBlock.
	self genMoveConstant: objectMemory nilObject R: ReceiverResultReg.
	^self genBlockReturn