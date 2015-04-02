testing
instructionIsAnyB: instr 
	"is this any of the B BX BL or BLX <offset> instructions?"
	^ (self instructionIsB: instr)
		or: [self instructionIsBL: instr]
		or: [self instructionIsBLX: instr]
		or: [self instructionIsBX: instr]