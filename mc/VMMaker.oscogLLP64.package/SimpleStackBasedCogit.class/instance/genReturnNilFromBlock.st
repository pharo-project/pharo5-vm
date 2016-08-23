bytecode generators
genReturnNilFromBlock
	self assert: inBlock.
	self genMoveNilR: ReceiverResultReg.
	^self genBlockReturn