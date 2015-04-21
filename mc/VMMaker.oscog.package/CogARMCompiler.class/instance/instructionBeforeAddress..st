inline cacheing
instructionBeforeAddress: followingAddress
	"Answer the instruction immediately preceeding followingAddress."
	<inline: true>
	^objectMemory longAt: followingAddress -4