inline cacheing
literalBeforeFollowingAddress: followingAddress
	"Return the literal referenced by the instruction immediately preceding followingAddress."
	^objectMemory longAt: (self pcRelativeAddressAt: (self instructionAddressBefore: followingAddress))