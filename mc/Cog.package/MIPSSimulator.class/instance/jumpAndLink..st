instructions - control
jumpAndLink: instruction
	| nextPC |
	self assert: inDelaySlot not.
	self unsignedRegister: RA put: pc + TwoInstructions. "Return past delay slot."
	jumpingPC := pc.
	pc := pc + OneInstruction.
	nextPC := (pc bitAnd: 16rF0000000) + (instruction target << 2). "Region is that of the delay slot."	
	self executeDelaySlot.
	pc := nextPC - OneInstruction. "Account for general increment"