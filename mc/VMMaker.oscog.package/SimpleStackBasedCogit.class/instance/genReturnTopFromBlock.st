bytecode generators
genReturnTopFromBlock
	self assert: inBlock.
	self flag: 'currently caller pushes result'.
	self PopR: ReceiverResultReg.
	^self genBlockReturn