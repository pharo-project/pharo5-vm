inline cacheing
literal32BeforeFollowingAddress: followingAddress
	"Answer the 32-bit literal embedded in the instruction immediately preceding followingAddress."
	^  ((objectMemory byteAt: followingAddress - 1) << 24)
	+  ((objectMemory byteAt: followingAddress - 2) << 16)
	+  ((objectMemory byteAt: followingAddress - 3) << 8)
	+   (objectMemory byteAt: followingAddress - 4)