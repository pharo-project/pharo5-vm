testing
instructionIsAnyB: instr
	"is this any of the B BX BL or BLX <offset> instructions?"
	^(instr >> 25 bitAnd: 7) = 5