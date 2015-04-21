inline cacheing
relocateMethodReferenceBeforeAddress: pc by: delta
	"If possible we generate the method address using pc-relative addressing.
	 If so we don't need to relocate it in code.  So check if pc-relative code was
	 generated, and if not, adjust a long sequence."
	| location |
	(self isPCRelativeValueLoad: (self instructionBeforeAddress: pc - 4)) ifFalse:
		[location := self extract32BitOperandFrom4InstructionsPreceeding: pc - 4.
		 location := location + delta.
		 self insert32BitOperand: location into4InstructionsPreceeding: pc - 4]