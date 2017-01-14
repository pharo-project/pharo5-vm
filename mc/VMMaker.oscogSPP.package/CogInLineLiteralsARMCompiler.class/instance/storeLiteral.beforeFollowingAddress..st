inline cacheing
storeLiteral: literal beforeFollowingAddress: followingAddress
	"Rewrite the long constant loaded by a MOV/ORR/ORR/ORR
	 or MOV/ORR/ORR/ORR/PUSH  sequence, just before this address:"
	^(self instructionIsOR: (self instructionBeforeAddress: followingAddress))
		ifTrue: [self insert32BitOperand: literal into4InstructionsPreceding: followingAddress]
		ifFalse: [self insert32BitOperand: literal into4InstructionsPreceding: followingAddress - 4]