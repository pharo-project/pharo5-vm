bytecode generators
genReturnTopFromBlock
	self assert: inBlock.
	self ssTop popToReg: ReceiverResultReg.
	self ssPop: 1.
	needsFrame ifTrue:
		[self MoveR: FPReg R: SPReg.
		 self PopR: FPReg].
	backEnd hasLinkRegister ifTrue:
		[self PopR: LinkReg].
	self RetN: methodOrBlockNumArgs + 1 * BytesPerWord.
	^0