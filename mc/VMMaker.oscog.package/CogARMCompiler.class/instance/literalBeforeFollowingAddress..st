inline cacheing
literalBeforeFollowingAddress: followingAddress
	"Answer the long constant loaded by a MOV/ORR/ORR/ORR
	 or MOV/ORR/ORR/ORR/PUSH  sequence, just before this address:"
	^(self instructionIsOR: (self instructionBeforeAddress: followingAddress))
		ifTrue: [self extract32BitOperandFrom4InstructionsPreceeding: followingAddress]
		ifFalse: [self extract32BitOperandFrom4InstructionsPreceeding: followingAddress - 4]