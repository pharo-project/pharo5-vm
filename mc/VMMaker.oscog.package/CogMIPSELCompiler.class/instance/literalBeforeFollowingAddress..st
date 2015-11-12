inline cacheing
literalBeforeFollowingAddress: followingAddress
	"Answer the literal embedded in the instruction immediately preceding followingAddress.
	 This is used in the MoveCwR, PushCwR and CmpCwR cases."
	
	"lui/ori, lui/ori/sw/addi, lui/ori/subu/slt/slt/sltu/sltu"
	
	| lastInstruction lastOpcode lastFunction oriAddress |
	lastInstruction := objectMemory longAt: followingAddress - 4.
	lastOpcode := lastInstruction >> 26.
	lastFunction := lastInstruction bitAnd: 63.
	oriAddress := 0.
	lastOpcode = ORI ifTrue: [oriAddress := followingAddress - 4].
	lastOpcode = ADDIU ifTrue: [oriAddress := followingAddress - 16].
	(lastOpcode = SPECIAL and: [lastFunction = SLTU]) ifTrue: [oriAddress := followingAddress - 24].
	self assert: oriAddress ~= 0.
	^self literalAtAddress: oriAddress
