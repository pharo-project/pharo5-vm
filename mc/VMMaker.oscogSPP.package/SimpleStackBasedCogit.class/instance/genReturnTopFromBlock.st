bytecode generators
genReturnTopFromBlock
	self assert: inBlock > 0.
	self PopR: ReceiverResultReg.
	^self genBlockReturn