inline cacheing
storeLiteral32: literal beforeFollowingAddress: followingAddress
	"Rewrite the 32-bit literal in the instruction immediately preceding followingAddress."
	objectMemory
		byteAt: followingAddress - 1 put: (literal >> 24 bitAnd: 16rFF);
		byteAt: followingAddress - 2 put: (literal >> 16 bitAnd: 16rFF);
		byteAt: followingAddress - 3 put: (literal >>   8 bitAnd: 16rFF);
		byteAt: followingAddress - 4 put: (literal            bitAnd: 16rFF)