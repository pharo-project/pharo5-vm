instructions - control
jumpAndLinkRegister: instruction
	| nextPC |
	self assert: inDelaySlot not.
	self unsignedRegister: instruction rd put: pc + TwoInstructions. "Return past delay slot."
	nextPC := self unsignedRegister: instruction rs.
	jumpingPC := pc.
	pc := pc + OneInstruction.
	self executeDelaySlot.
	pc := nextPC.
	pc := pc - OneInstruction. "Account for general increment"