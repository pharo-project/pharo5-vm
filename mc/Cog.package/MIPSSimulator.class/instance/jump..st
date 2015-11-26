instructions - control
jump: instruction
	| nextPC |
	self assert: inDelaySlot not.
	jumpingPC := pc.
	pc := pc + OneInstruction.
	nextPC := (pc bitAnd: 16rF0000000) + (instruction target << 2). "Region is that of the delay slot."	
	self executeDelaySlot.
	pc := nextPC - OneInstruction. "Account for general increment"