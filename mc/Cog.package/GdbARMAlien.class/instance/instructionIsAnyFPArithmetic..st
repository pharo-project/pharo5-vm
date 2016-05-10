testing
instructionIsAnyFPArithmetic: instr
	"Identify single register transfer and double register transfer VFP instructions.
	 See C3.3 & C3.4 in the ARM ARM."
	| oneRegTransferMask twoRegTransferMask |
	oneRegTransferMask := 16rF000F00.
	(instr bitAnd: oneRegTransferMask) = 16rE000A00 ifTrue:
		[^true].
	(instr bitAnd: oneRegTransferMask) = 16rE000B00 ifTrue:
		[^true].
	twoRegTransferMask := 16rFE00FC0.
	(instr bitAnd: twoRegTransferMask) = 16rC400A00 ifTrue:
		[^true].
	(instr bitAnd: twoRegTransferMask) = 16rC400B00 ifTrue:
		[^true].
	^false