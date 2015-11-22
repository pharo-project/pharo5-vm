inline cacheing
literalBeforeFollowingAddress: followingAddress
	"Return the literal referenced by the instruction immediately preceding followingAddress."
	^objectMemory longAt: (self pcRelativeAddressAt:
		((self instructionIsLDR: (self instructionBeforeAddress: followingAddress))
			ifTrue: [self instructionAddressBefore: followingAddress]
			ifFalse: [self instructionAddressBefore: followingAddress - 4]))