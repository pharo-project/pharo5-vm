inline cacheing
instructionBeforeAddress: followingAddress
	"Answer the instruction immediately preceding followingAddress."
	<inline: true>
	^objectMemory longAt: (self instructionAddressBefore: followingAddress)