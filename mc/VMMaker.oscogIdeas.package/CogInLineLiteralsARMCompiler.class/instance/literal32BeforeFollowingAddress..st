inline cacheing
literal32BeforeFollowingAddress: followingAddress
	"Answer the 32-bit constant loaded by a MOV/ORR/ORR/ORR
	 or MOV/ORR/ORR/ORR/PUSH, or MOV/ORR/ORR/ORR/CMP sequence, just before this address:"
	^(self instructionIsOR: (self instructionBeforeAddress: followingAddress))
		ifTrue: [self extract32BitOperandFrom4InstructionsPreceding: followingAddress]
		ifFalse: [self extract32BitOperandFrom4InstructionsPreceding: followingAddress - 4]