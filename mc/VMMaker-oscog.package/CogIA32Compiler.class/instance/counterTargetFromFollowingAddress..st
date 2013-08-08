sista counters
counterTargetFromFollowingAddress: nextInstructionAddress
	"Answer the address of the MoveAw:R or MoveR:Aw: instruction preceeding nextInstructionAddress"
	^self literalBeforeFollowingAddress: nextInstructionAddress