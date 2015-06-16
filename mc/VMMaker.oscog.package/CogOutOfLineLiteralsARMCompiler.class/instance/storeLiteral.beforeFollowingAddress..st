inline cacheing
storeLiteral: literal beforeFollowingAddress: followingAddress
	"Rewrite the literal in the instruction immediately preceeding followingAddress."
	objectMemory longAt: (self pcRelativeAddressAt: followingAddress - 4) put: literal