inline cacheing
instructionBeforeAddress: followingAddress
	"Answer the instruction immediately preceeding followingAddress."
	^objectMemory longAt: followingAddress -4

	" old version - ^  ((objectMemory byteAt: followingAddress - 1 235) << 24)
	+  ((objectMemory byteAt: followingAddress - 2) << 16)
	+  ((objectMemory byteAt: followingAddress - 3) << 8)
	+   (objectMemory byteAt: followingAddress - 4)"
