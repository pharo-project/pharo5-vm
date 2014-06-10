inline cacheing
literalBeforeFollowingAddress: followingAddress
	"Answer the long constant loaded by a MOV/ORR/ORR/ORR sequence just before this address:"
	^  ((objectMemory byteAt: followingAddress - 16) << 24)
	+  ((objectMemory byteAt: followingAddress - 12) << 16)
	+  ((objectMemory byteAt: followingAddress - 8) << 8)
	+   (objectMemory byteAt: followingAddress - 4) 