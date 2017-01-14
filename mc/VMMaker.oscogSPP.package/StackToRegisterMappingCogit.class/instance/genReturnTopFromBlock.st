bytecode generators
genReturnTopFromBlock
	self assert: inBlock > 0.
	self ssTop popToReg: ReceiverResultReg.
	self ssPop: 1.
	^self genBlockReturn