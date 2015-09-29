inline cacheing
storeLiteral: literal beforeFollowingAddress: followingAddress
	"Rewrite the literal in the instruction immediately preceding followingAddress."
	objectMemory longAt: (self pcRelativeAddressAt: followingAddress - 4) put: literal