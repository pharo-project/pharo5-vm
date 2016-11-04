bytecode generators
genReturnNilFromBlock
	self assert: inBlock > 0.
	self genMoveNilR: ReceiverResultReg.
	^self genBlockReturn