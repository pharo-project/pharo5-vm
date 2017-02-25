inline cacheing
jumpLongTargetBeforeFollowingAddress: mcpc 
	"Answer the target address for the long jump immediately preceding mcpc"
	self assert: (objectMemory longAt: mcpc - 4) == self nop. "Delay slot"
	self assert: (self opcodeAtAddress: mcpc - 8) == SPECIAL.
	self assert: (self functionAtAddress: mcpc - 8) == JR.
	^self literalAtAddress: mcpc - 12
	