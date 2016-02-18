bytecode generators
genReturnTopFromBlock
	self assert: inBlock.
	self PopR: ReceiverResultReg.
	^self genBlockReturn