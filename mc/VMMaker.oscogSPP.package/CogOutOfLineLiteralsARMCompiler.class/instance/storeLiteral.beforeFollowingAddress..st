inline cacheing
storeLiteral: literal beforeFollowingAddress: followingAddress
	"Rewrite the literal in the instruction immediately preceding followingAddress."
	objectMemory
		longAt: (self pcRelativeAddressAt:
					((self instructionIsLDR: (self instructionBeforeAddress: followingAddress))
						ifTrue: [self instructionAddressBefore: followingAddress]
						ifFalse: [self instructionAddressBefore: followingAddress - 4]))
		put: literal