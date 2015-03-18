inline cacheing
instructionBeforeAddress: followingAddress
	"Answer the instruction immediately preceeding followingAddress."
	^objectMemory longAt: followingAddress -4