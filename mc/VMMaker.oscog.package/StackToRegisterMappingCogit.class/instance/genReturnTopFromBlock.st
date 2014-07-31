bytecode generators
genReturnTopFromBlock
	self assert: inBlock.
	self ssTop popToReg: ReceiverResultReg.
	self ssPop: 1.
	^self genBlockReturn