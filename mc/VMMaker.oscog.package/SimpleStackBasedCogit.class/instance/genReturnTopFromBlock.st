bytecode generators
genReturnTopFromBlock
	self assert: inBlock.
	self flag: 'currently caller pushes result'.
	self PopR: ReceiverResultReg.
	needsFrame ifTrue:
		[self MoveR: FPReg R: SPReg.
		 self PopR: FPReg].
	backEnd hasLinkRegister ifTrue:
		[self PopR: LinkReg].
	self RetN: methodOrBlockNumArgs + 1 * BytesPerWord.
	^0