testing
isJumpAt: pc
	| instr |
	instr := objectMemory long32At: pc.
	^(self instructionIsB: instr)
	  or: [self instructionIsBX: instr]