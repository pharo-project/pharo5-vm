instructions - control
jumpRegister: instruction
	| nextPC |
	self assert: inDelaySlot not.
	nextPC := self unsignedRegister: instruction rs.
	jumpingPC := pc.
	pc := pc + OneInstruction.
	self executeDelaySlot.
	pc := nextPC.
	pc := pc - 4. "Account for general increment"