inline cacheing
instructionBeforeAddress: followingAddress
	"Answer the instruction immediately preceding followingAddress."
	<inline: true>
	^objectMemory longAt: followingAddress -4