inline cacheing
storeLiteral: literal beforeFollowingAddress: followingAddress
	"Rewrite the literal in the instruction immediately preceding followingAddress."
	objectMemory longAt: (self pcRelativeAddressAt: (self instructionAddressBefore: followingAddress )) put: literal